Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F23546EC;
	Mon, 22 Jun 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104225; cv=none; b=bhk8mH2Vyl9hKiF0eFZMt7kM0aLtlHxPpEOOO4V0hvhaTiZMNEwh9PgfB/PEwknPAHtD/maj5k6JEkKfAey6h95lsBa4G1w118SCCbs1rTUjuyjxjdypalAXnQKE7bXEKCMTmhTmLxwJHzrB2Z39h5zsIY1oVKeOa2hSuHIng3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104225; c=relaxed/simple;
	bh=y20wWhvyV+JEdAEaIZYj+ZkpGg59Wx+I1Rgu6CdOWA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKoSSF5b7hFh44Jwrl46f81KegfALz/nIxC0+KDCuN/uA2dNbiP2eMag2lceyP4rTzucoMfSY9s7+zIjuxXvlQH3vdaXea/BewhptTO6uc/LWuDZA7+MjEoX0QmBklgWWZ5wViQOoioXG+Njh1IiP3TsrhpXLvbs9N7E97a1BW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=EN5ffPuG; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="EN5ffPuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=X1qBX
	cBkQZ+6/Z6ZgmhR98JHCl8KywaI9S7W0PyqSuc=; b=EN5ffPuGh9OmMXR/9Bb3M
	tOarvtzHfW0OrFjPPFBtFUfWyrZsKV6/L3NAoslRgxyHgVixgLqWSbHvZ0SNpI8g
	DgLDpIdW/Use+4cTDOL/EKWp4BI+X+hZJQTyjDMb73AWOg893xk7tubRRDSsXSU7
	n9eip9FcHsk5RUaglbYEts=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBHWZ6GwDhqUmtwAg--.53540S2;
	Mon, 22 Jun 2026 12:56:48 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Reject flexible-array allocation types
Date: Mon, 22 Jun 2026 04:56:35 +0000
Message-Id: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBHWZ6GwDhqUmtwAg--.53540S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr48AFy7tr47ur1kKr48JFb_yoWfArX_Z3
	yUtrWxu345uF1DAa4jvF1rJFyFkr45Gr1DZFZ5JrsrKFy5Aw4UCw1kJrnxXrnrWa13ArW3
	Xrs3Za48tr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-F4_UUUUU
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_obj_new() and bpf_percpu_obj_new() allocate only the static BTF size
for the selected program-BTF type.

A program-BTF struct can nevertheless end with a zero-length flexible array.
Generic BTF struct walks have special handling for such trailing arrays, and
can validate field accesses beyond the allocated static object size.

Patch 1 rejects allocation kfunc types with trailing flexible arrays.
Patch 2 adds a linked_list negative loader case for the rejection.

Yiyang Chen (2):
  bpf: Reject flexible-array allocation types
  selftests/bpf: Cover flexible-array allocation rejection

 kernel/bpf/verifier.c                         | 28 +++++++++++++++++++
 .../selftests/bpf/prog_tests/linked_list.c    |  2 ++
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++
 3 files changed, 53 insertions(+)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

