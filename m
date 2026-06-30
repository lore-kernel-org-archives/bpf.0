Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3312E9729;
	Tue, 30 Jun 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808931; cv=none; b=sHk3mRTJV1nsWS3acKDfdXfhosn5jVaTjX+no/U596x4Ywd0joxAB5R6q+tv2LxqrvmYN/abZO+THYhcPe9cQYN4oRi/pueAc8i/RTt11t2J9W3y4pq3IXyg9B+/YSA5LjPiiaIAFzfPwb8IHPtjgwpSHTuXKRa/98pk16DWGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808931; c=relaxed/simple;
	bh=4JVNHk7k7nEnkCg+WDVTBhjkTl7SyLorKiw8SkSKu1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qw6xzGCoYcy4EIrk1S1TPCo7Lgvr2jk56y7V9uBZ1rAhl+gnfVrcGS2HhJSWsaIzMJBTRVL7VAwaXHEg7l/ic3XQFqpqA+x4fC3XrtgC5PQzwc+zvKcHqN2/wKcrqkEToRvoinxikLwrjI4nJQr4F0aehgRHBN3M3Qag8VmsCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Ui/ksH67; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Ui/ksH67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=cSc7i
	7aALHrIS9SMWrRZZJU3ALNoFPly4B0adlHNLOw=; b=Ui/ksH67MQXyGOo4qXA25
	xXtgje3oH7+J5NgGsUqgCamAcH7/TRAWxCbaNe45uTmjQIQqM1M8sUbNd2Y5Zv7P
	NvqjFay9lVTV9N5n4TRAhND2wux0PR3BgRSe0y1ETg+2TknK9WnAGs5/iI6BWqab
	/DbuCLrlRMg6z85AM71FBs=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQCnbKE5gUNqiZafAg--.37989S2;
	Tue, 30 Jun 2026 16:41:47 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/2] bpf: Reject MEM_ALLOC BTF accesses past bounds
Date: Tue, 30 Jun 2026 08:41:25 +0000
Message-Id: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQCnbKE5gUNqiZafAg--.37989S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1UXryxJF4xJr15CF15Jwb_yoW8XryUpF
	WrJw1fAFW0vrWxZFnIya129rn8tay8Xr15G3WfK348ur1YyF1UXrWkKr1Yyr90y3sF9F15
	uFy09F9xG3W7uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjXTm3UU
	UUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

BTF struct walks can relax the top-level struct-size check for trailing
flexible arrays. That relaxation must not let a PTR_TO_BTF_ID | MEM_ALLOC
access escape the bytes allocated by bpf_obj_new() or bpf_percpu_obj_new().

Patch 1 rejects MEM_ALLOC BTF walks whose access range reaches past the
current struct size before applying the flexible-array relaxation. This now
also applies to struct ID matching used by kfunc and kptr type checks.
Patch 2 adds a linked_list negative loader case for this path.

Changes in v3:
- Pass the flexible-array walk policy through btf_struct_ids_match() callers,
  so MEM_ALLOC kfunc/kptr type checks use the same bounds rule.
- Rename the btf_struct_walk() parameter to walk_flex_arrays.
- Rebase onto current bpf-next.

v2:
https://lore.kernel.org/bpf/cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn/

v1:
https://lore.kernel.org/bpf/cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  bpf: Reject MEM_ALLOC BTF accesses past object bounds
  selftests/bpf: Cover MEM_ALLOC access past object bounds

 include/linux/bpf.h                           |  2 +-
 kernel/bpf/btf.c                              | 17 +++++++++-----
 kernel/bpf/verifier.c                         | 11 +++++----
 .../selftests/bpf/prog_tests/linked_list.c    |  1 +
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++++++
 5 files changed, 43 insertions(+), 11 deletions(-)


base-commit: 53435562a725962e4de0c29653223129ba11643a
-- 
2.34.1

