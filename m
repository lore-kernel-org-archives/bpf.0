Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF410401A14;
	Tue,  9 Jun 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016255; cv=none; b=N46bvgR/ZGAkWe8YTePV03SgoTGPQm3741BzNWD6HctIyjZMZxMYuJD6ZO/7SCzVurzz7QByXYlxLbI826hRC6shvPW9HsO9vstO/qYJpfqfIgHsUyDCFoIB7tI55Mao+PcK18Qk2I6IevMANETG9FaXO/f7m1COC8r1Eary+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016255; c=relaxed/simple;
	bh=mg1wm2aBlxY1HNYDtkr9Bs+r/1HT2sfOznftFJVgEPw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KMuvGcMORWi+ftXAmW5Q1ybyMssqxSwFcMGkzbwsazaSlkSsnWi+go9ac6YtsK2wONiiHVuu2AUtdeYfY0RZBvOab0BAiO1Ce6w16A4ef7gxCnrGadXmK1yprjbKf5ePuEb0d1vcE4IgIxXOumVDZ+PXeoNZ0J3JDuNsOE8d5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=q3ptnSgH; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="q3ptnSgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=wwHIALP3qo8/ByBe+wR6z0FuRRAUNDQbqHVYy/rE90Q=; b=q3ptnS
	gHJRXmXZ7eYxZJZx3XkBxE4HOvlaw72Fr6eeelTZ/0oLNo2E0e4hejZ7QhwukdAw
	Pi7UtfqCAMTai3aenLWoJdHyXzywqmVKDKzTtfh5nj+IcxavYIL5WZKfGUPsMK7X
	iCi5F9QcxRTk8RZVaEe0cLeQrmrgzcc+EzSV0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQDn+6CpJihq+OUeAg--.58007S2;
	Tue, 09 Jun 2026 22:43:53 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Enforce BTF pointer write checks for
 global args
Date: Tue, 09 Jun 2026 22:43:49 +0800
Message-Id: <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYmKGoC/yWM0QrCMAwAf2Xk2UA2pEx/RXxo2nRGpI6008HYv
 1v18TjuNihiKgXO3QYmLy36zA36Qwfh5vMkqLExDDQ4cnTCRD3SEbkmfJtWzw9BbxM6z5GjG6O
 EEVo9myRdf+cL8Jwwy1rh+jdl4buE+h3Dvn8ApHBJT4UAAAA=
X-Change-ID: 20260609-f01-04-btf-writable-arg-6abdbd68dec8
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016235; l=1624;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=mg1wm2aBlxY1HNYDtkr9Bs+r/1HT2sfOznftFJVgEPw=;
 b=p6CuBrB5hGtCSNpUozCb3lKnKnNCYqxb2J+lclLJZqR94ZkURbqh6XxcxFkmfJLSQdxzxXkmW
 fJxRcb65rDaC8pC1h5s8koz2OU++YHi+5AI3DpLzW4HgCo494afNpSu
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQDn+6CpJihq+OUeAg--.58007S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Gw4DCrWDXw1kXrWkJFb_yoW8Wr43pF
	1Fgry3KrWUAan2kasFya4jgayYqr4kGFy3GFsFyr1ayFs3GF1DGrWIga4DZFyYqrn5W3yk
	WrWqqr9xWa1UGFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0hSdPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgMNA2onzACbaQAAs8

check_mem_reg() verifies both read and write access when a caller passes
memory into a global subprogram. For PTR_TO_BTF_ID callers,
check_helper_mem_access() currently always checks the access as BPF_READ.

That lets a tracing program pass a task_struct field pointer to a global
subprogram argument typed as writable memory. The direct field store is rejected
with "only read is supported", but the callee is validated with a generic
writable PTR_TO_MEM argument and can store through it.

Forward the requested access type into the PTR_TO_BTF_ID helper-access path and
add verifier coverage for the global-subprogram argument case.

Validation (tested on bpf-next 8496d9020ff3):

  Without this series:
    direct BTF field store rejected with "only read is supported";
    global-subprogram candidate loaded, attached, and runtime-confirmed.

  With this series applied:
    direct BTF field store rejected with "only read is supported";
    global-subprogram candidate rejected with "only read is supported".

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Enforce write checks for BTF pointer helper access
      selftests/bpf: Cover writable BTF field global subprog args

 kernel/bpf/verifier.c                                 |  2 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: b9452b594fd3aecbfd4aa0a6a1f741330a37dab7
change-id: 20260609-f01-04-btf-writable-arg-6abdbd68dec8

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

