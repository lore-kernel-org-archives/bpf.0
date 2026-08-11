Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64C3FB7EB
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442188; cv=none; b=sCmiu9ynwB/mO/ClELsd0JQEjgVRhwFVmC12+35iuzJWdBGi2gNQi+q9iwR+uaqPEeZmdNDtJkVEnxjiEcMjjcT4VctaFViyhPaoZDJ0rYmjSyYdonln9rhoAlMh9YfMc6fpRoQzwmiqKQFru+x2OUsiEJL4c7PYqsIJHk/BDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442188; c=relaxed/simple;
	bh=gBlm+D9pvlb1QJu9Pcg2U0VeTmni9WtgIJRl1R/z0kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGH3T3N31Sm81Skodb9/vMnYDLQKZXC0peizcUb5P4b0k3yQHWZ/Uq/gyo0tXVw+x36hZj8lcomqnVn0wN0a3ep3C9R1EIlIlXsNtgK/IkRo40DBLopLrhQN5/sO56gb+u1jjZr8cAH9eOplZTlQDdQMkynF/iH8XLy3QKcsrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mG6zbalp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mG6zbalp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pc
	11ZRPnXzkfoPKs0S7UHR/r6yN7Jj/EWeEiY4lXNfQ=; b=mG6zbalp/Lwux5R34w
	DHz8bfei0Sfu3QeGwIXXQfhI8O81OKLD3QUpn1m3zLKuul1E7TFh22sKgJPBQg0J
	jwHj9Bd/ikrZWnQL/tJIq5zZ9hd+3cHj/v4G4OrIQpBlYqbYoLhTJfZZatTQqSAF
	pNjDtJomdKBYB/NCnfTLoSbS8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnnhic8XpqSKdbPA--.38984S2;
	Tue, 11 Aug 2026 17:55:41 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 0/2] bpf: Cancel special fields in resizable hashtab on recycle
Date: Tue, 11 Aug 2026 17:55:29 +0800
Message-ID: <20260811095531.3294167-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnhic8XpqSKdbPA--.38984S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw13JFyDJr4ruw4UGF47XFb_yoW8Jw4rpF
	WrW343tr1IyFn7twn3Kay2q34rG3Z5JF45CF43tryYy34rXr9rJr4fKF45AFn5tr4rXrna
	v3Z2qr9xCw4Yy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFYLkUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAh3cmmp68Z35GgAA3G

From: Yuan Chen <chenyuan@kylinos.cn>

The resizable hashtab (BPF_MAP_TYPE_RHASH) still eagerly calls
bpf_obj_free_fields() when an element is deleted or its value is
replaced, which runs kptr destructors in the caller's execution context.
This is unsafe for BPF programs running in NMI context (e.g. perf_event
programs attached to hardware PMU overflows), where referenced kptr
destructors may take locks or otherwise cannot run.

Commit a3a81d247651 ("bpf: Cancel special fields on map value recycle")
switched the hash map and array recycle paths to bpf_obj_cancel_fields(),
which only cancels NMI-safe fields (timer, workqueue, task_work), but it
missed the resizable hashtab. Patch 1 applies the same semantics to
rhtab; patch 2 adds a regression test.

Yuan Chen (2):
  bpf: Cancel special fields in resizable hashtab on recycle
  selftests/bpf: Test rhtab kptr recycle from NMI context

 kernel/bpf/hashtab.c                          |  28 +++--
 .../selftests/bpf/prog_tests/rhtab_kptr.c     |  87 +++++++++++++++
 .../testing/selftests/bpf/progs/rhtab_kptr.c  | 101 ++++++++++++++++++
 3 files changed, 207 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c

-- 
2.54.0

