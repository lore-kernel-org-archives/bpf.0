Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002604DA9C7;
	Mon,  5 Oct 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225232; cv=none; b=twwESdY2lq6SdZ9RFCRFlIsfmOWFjEoTJm0lNvx1XTrgT7dCluRpoCuQd7YtyjoZYD23tf6Jc90SCeV5Pu/C+vGSzMZBFnf4o8VGuWjZqAzkqqAOGykVaTPc1jPlVyEkwK+y8dyY4M8e6BtZVlNIou+agH6xTA/iQ7Ui4thVfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225232; c=relaxed/simple;
	bh=p5yCHhBPJLKXdXhxeKY1vvHRtoauk1kTbjSYAkleWg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cAFUi1mLTsAjwi6+SIeV4KcKb2H6Q7qObybJkbUPThWYIfVMaTs3lhmpE3WMyV6PV2fVuVndKaRpG46/IMqDbaWfLJQnXjfKtS/9I0bGuAsDRCcc1lko8hwuZ/ydDP2x9hmobqoo2M5j/ojOzM5SDGVNfcIAuolah+LtKhTNn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Md1X8AL/; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Md1X8AL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=T95qC0pzSHvs4GhCg3bJgZH+eR2orz2hga4ZZwa37zU=; b=Md1X8A
	L/NINZlJOxxUfTsOAFNXJ9c/dieFm6HhWOcMw0o2GjxtcZj5vtpoAvVphqi8qqSO
	W76VD7CdgGVB2RsbSpAf1sL+dFVAozs3DHqMSij1UGxQS9+AFTdI/eXBVo5hIX69
	gf2EVNqOVWaP6FyhOB8/KDaN0XCHQ1WQFpsok=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQAXjj5z7cNqfPTAAA--.64526S2;
	Tue, 06 Oct 2026 02:33:26 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v2 0/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
Date: Mon, 05 Oct 2026 18:33:22 +0000
Message-Id: <20261005-a3-arg-trusted-v4-v2-0-319ce2936949@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLtw2oC/32NSwqDMBCGryKz7kh8pGhX3qO4iGbUgTZKJoYW8
 e4NHqDL//X9Bwh5JoFHdoCnyMKrS6K8ZTAuxs2EbJOGUpX3QimNpkLjZwx+l0AWY42t1batG01
 6MJB2m6eJPxfzCcM2QZ/MhSWs/nv9xOKK/iBjgQq1IkqVZrJV270NvyQPwm5edpOT3fPRQX+e5
 w87LeoIwwAAAA==
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
 Song Liu <song@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791225207; l=2120;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=p5yCHhBPJLKXdXhxeKY1vvHRtoauk1kTbjSYAkleWg4=;
 b=4ummkQJCuAto+nsdF+TC+qthdcvGfRwoVKm4YUUwfzuofzGPCv/j04RCwXA72Y/bvWTXK6G5W
 8j3YV1WmdoKBdkbMKi34q9papGm8okESYk/I+OuzDIlmNRs5X+jWZjy
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQAXjj5z7cNqfPTAAA--.64526S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw15Jr17KFWUAFWkuw1fCrg_yoW8uF4xpF
	4rGrn0vr4kGFsFy3yftF4xZFWYvrs5Aay5Cr1xJa4xCFZ8WFWxJryFkrs8W3WYvr95G34Y
	qFyavrn0g3yUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62
	xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK
	67AK6ryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUbnmRUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is specified to accept
only the PTR_TRUSTED flavor of PTR_TO_BTF_ID, but the call-site check in
btf_check_func_arg_match() also accepts a bare PTR_TO_BTF_ID and an MEM_RCU
one.

check_reg_type() resolves the accepted set from the base argument type alone
and compares only MEM_RDONLY and PTR_MAYBE_NULL, so the PTR_TRUSTED bit of
arg_type is never consulted. btf_ptr_types lists bare PTR_TO_BTF_ID and
PTR_TO_BTF_ID | MEM_RCU alongside the trusted flavor, and nothing else on the
subprogram call path requires the register to be referenced or trusted.

The callee is then validated with PTR_TRUSTED set on the register while the
caller passed a pointer that is neither referenced nor trusted.
bpf_may_fault_on_deref() is false for PTR_TRUSTED, so the dereference becomes
a raw load instead of a BPF_PROBE_MEM probe and the callee can pass the
pointer on to a kfunc that would have rejected it at the original call site.

Reject a PTR_TO_BTF_ID that is neither referenced nor trusted when the
argument is marked PTR_TRUSTED. A referenced register is accepted, as in
is_trusted_reg(). PTR_MAYBE_NULL is not counted as unsafe when __arg_nullable
declares it, so trusted-and-nullable arguments keep working. The kfunc path
is unchanged.

Changes in v2:
- Retarget the fix to btf_check_func_arg_match(), where the subprogram
  argument check lives in this tree, instead of check_func_arg().
- Run the check after check_reg_type() and check_func_arg_reg_off() so type
  and offset diagnostics keep their wording.

v1: https://lore.kernel.org/bpf/20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn/

Yiyang Chen (2):
      bpf: Require referenced or trusted pointer for __arg_trusted arg
      selftests/bpf: Cover non-trusted pointer to __arg_trusted subprog arg

 kernel/bpf/verifier.c                              | 24 +++++++++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 40 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)

base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc

--
2.34.0

