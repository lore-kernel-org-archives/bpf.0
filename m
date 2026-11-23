Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413490;
	b=HYDUobmpYffN6Rr6DHi6pxFjG5nAbSyZBzSk8WYVLd6Gt9wVUAtlHay02x20472zLVRz
	 b7RJ95hrtX8dwWEPCLVN2SHK5wQn3Kp1qC4lHnwh/aiAAqPXzS/DKfEY97j84OEO2IaEu
	 BCjF4mBWuoFgZAoDEUWViuKIxFr3DSTx25XL4IeQCWANUimZJTD3uCQZw9/QH2PLwBlNM
	 FtU/vN/w1S6VVBfgt6iMDK+tn4BoovtznQs3nr6vsMf+DPMZYgdLoAianQgybaQOWrGDI
	 gZypIjLeUqwLy5yMvw0fmxiKWc0p1lPaIbWTPA7VhNbPenQO5Wwy+ALEhOx+CNgMPsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413490;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=elNBZl1Qhes7dZY1lKzHBBkpcvZM9uu3IWksMdE12xs=;
	b=bHO3x8Z7svA8T1EUAjNv8s1tgjFE3U3qwzlDXgQr8bAJ/Pt8dwc2gVaC7Pnis4avKtYO
	 a7K20ZAgKdGflzwJVxgL2tEhsS4UQtGeePCollIUc1GoNonzVYbOQEDfa59ysoj8VKDjY
	 80FCFa6yJkWNmwAruRIivATDaHYRIRB04dRrq9ZdqKdtGkS7fU04JPYM218jfmyVgHdBu
	 BBxzzmcVFLBko8ZCDmEQb64ZHDMaUdVvXnOalO/5jjYMN50dvCAayfucGSgEZyNZVduoJ
	 ZD5d9qi5JfqByGMn17iolC6kEICk3tYfRZ847pOSnes74RroS9D5RsLppJza+nNzF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CTZsBjQ+;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA1606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BCA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CTZsBjQ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=el
	NBZl1Qhes7dZY1lKzHBBkpcvZM9uu3IWksMdE12xs=; b=CTZsBjQ+o3oxViKv6R
	5ocfplFgy5A4CtO08JzoxsdtkNkglD7FWxuzUswqMgQqKO41V4QFbRsS3b0+Ou3T
	NPP4YKqZwxcaSrJotMxhp6XfGVjZaPeqt7OkJemGOBOONAvhkMbDmFEB54yeA8F1
	IhAN29PX/u0u4Q19G45YJdP/g=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3dzy+1QNrMgTmJg--.22062S2;
	Mon, 23 Nov 2026 13:57:19 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	ihor.solodrai@linux.dev,
	memxor@gmail.com,
	nirmoyd@nvidia.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v7 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Mon, 23 Nov 2026 13:57:06 +0800
Message-ID: <20261123055708.684107-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dzy+1QNrMgTmJg--.22062S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDZFW5tF4rKF43GrWkCrg_yoW5Jr4kpF
	4rtFn0kr4kJa4xKa4Skr4xXw1Fgan5J3y5GF95Ka4FyFs09ry8XFyfKF1FgFW5tr9xX3y2
	vFySqrZ5W3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0SoJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQFB-msD1cFjaAAA3I

From: Yuan Chen <chenyuan@kylinos.cn>

v6: https://lore.kernel.org/bpf/20260609125214.3096351-1-chenyuan_fl@163.com/

v1 made btf_types_are_same() cross-BTF aware by comparing kind, size
and name.  Alan Maguire pointed out that this would be too permissive
since two different structs can share the same name and size.

v2 used a name-based classifier (get_kfunc_arg_inject_type).

v3 splits the combined is_kfunc_arg_ignore || is_kfunc_arg_implicit
check in check_kfunc_args(), so that an implicit argument reaching
is_kfunc_arg_implicit() without any prior handler is rejected with
-EFAULT instead of silently skipped (Eduard Zingerman).  This prevents
the silent fallthrough that occurred when module BTF was inconsistent
with vmlinux (e.g. pahole 1.30 breaking distilled base dedup).

v4: fix a build error in the selftest.

v5 changes:
- Patch 1: extend the kfunc allow-list to cover all KF_IMPLICIT_ARGS
  kfuncs handled in bpf_fixup_kfunc_call(): obj_new, percpu_obj_new,
  obj_drop, percpu_obj_drop, refcount_acquire, list_push, rbtree_add.
- Patch 2: simplify the selftest by verifying aux->name in
  bpf_kfunc_implicit_arg() instead of adding a separate struct_ops
  test program with inline assembly.

v6 changes:
- Patch 1: fix comment formatting to follow kernel style (Eduard
  Zingerman).

v7 changes:
- Rebase onto bpf-next.  The argument check now lives in
  get_kfunc_arg_type(), so the fix is applied there.
- Restore the Acked-by tag from Eduard Zingerman that was dropped in
  v6.
- Patch 2: verify the aux->prog backlink instead of matching aux->name.
  The tracing selftest added in 0af15f30 calls the same kfunc from
  programs named trace_implicit_arg_*, so a name prefix check would
  make it fail.

The v6 CI build errors came from applying the series to the bpf tree:
argno and reg_arg_name() were introduced by bpf-next 9b9f0b42703c,
on which this series is based.

v6 was tested by Nirmoy Das on a kernel with a module BTF mismatch:
the unpatched kernel oopsed and v6 rejected the program at load time.

Yuan Chen (2):
  bpf: Fix kfunc implicit arg inject type detection to prevent invalid
    pointer deref
  selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

 kernel/bpf/verifier.c                              | 20 +++++++++++++++++++-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  8 +++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.54.0

