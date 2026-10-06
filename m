Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B633123D;
	Tue,  6 Oct 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302815; cv=none; b=dmpv7hmBTClXANEDVyyFYX2LrV+M4Xbao8T2Wt+1TsVpgmbHuAduEHAq9mD+EpGdDIAvkHPQE9nmGbgK8AGXEwGcOGt0Z0Sh/nrz3aO8thA2IjdOphpHrTofnAI+zDw3Dzb+xANyXYJF1e3snjXqjFBrsky+LXO+ZyPjE54A+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302815; c=relaxed/simple;
	bh=Ih41x7twpb2q7/kKLnEHgdfRbbxz0+Qqhdz+wPUBAk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fmzpkIZUICG3Q4vyV66Hr6aZS4BiR3FlHK/y1p81sHQbfyQwtkf11M15N1TK0gMuw4Iu6JPcWtX4esaE4bBICxihp7qiKl7ttdh+1YQp6ZDqiwpZkEUCGOZrHhDRc623JB2BOV8gyanYwubJE8ZbEpa1Rykin/XGxEAOFkQfRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ObDJyxNd; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ObDJyxNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=CdWZRGNitDFSBGx1NOHdxILXYcWaw3UisS4Ov21swjk=; b=ObDJyx
	Nd4xrk19s9RPvtJUdU0L195U/Jq0EahDati6egUjw+QgqGYHxsyT7pJ6xcNRO+Wd
	SZtB0FpbezTmR3Er2uubdN8DYHe6OtQEETHTaC7AQ9Y19fw66hle+lsdErFKg4k4
	dpBqpnytfKSguyvjhgqFHuioAoUJq48GSOc/c=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBXhGiBHMVqrZhzAA--.54037S2;
	Wed, 07 Oct 2026 00:06:32 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v3 0/2] bpf: Reject bare pointer for __arg_trusted arg
Date: Tue, 06 Oct 2026 16:06:24 +0000
Message-Id: <20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAcxWoC/4XNwQ6DIAwG4FcxPQ+DIEZ22nssO6BUbbIxA0i2G
 N99hPu249/+/bpDQE8Y4Fzt4DFRoKfLQZ4qGBfjZmRkcwbBRddwrpiRzPiZRb+FiJallmmrrG5
 7hWowkO9WjxO9inmFYZ3glocLhfj07/InNWX1g0wN40xxxFzpJyv15WHoHuoYyM3LZmq0Wz26I
 ifxVxNZk40eUWjZ6fardhzHB2ogFZERAQAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791302794; l=1903;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=Ih41x7twpb2q7/kKLnEHgdfRbbxz0+Qqhdz+wPUBAk0=;
 b=bPD0wRniBlasM+90GcAjaMbGRRpjSDDt1fMg8wqqMpSfaBlhqNPrAizRPTZEoGzFrQmbFzVF8
 S/mT6LXvGqcBZ4aEd5fW6N4C6N2yJs7sbYmqniQDb22SQLiTQACpuGe
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQBXhGiBHMVqrZhzAA--.54037S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1fXrWrXr15uryUCF45KFg_yoW8Cw45pF
	4rX34agr48GFsrJ343tFW7u3yFgrs5AayUCw1xJ34UuF45WFy7ArySgrW5uwn8urn8Cr10
	qFy8Zwn09w15Z3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjylkDUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is verified as holding a
PTR_TRUSTED pointer, but its call-site type check also accepts bare
PTR_TO_BTF_ID. This lets a caller pass a pointer without lifetime protection
to code verified for raw trusted-pointer accesses.

Reject the bare pointer while preserving referenced, trusted, and
RCU-protected arguments. The latter is used by sched-ext programs that pass
the result of an RCU-protected kfunc through trusted-and-nullable global
subprogram arguments.

Add a rejection test for the bare pointer and a positive regression test for
the RCU-protected case.

This series targets bpf, which uses separate global-subprogram and kfunc
argument checkers.

Changes in v3:
- Preserve RCU-protected arguments accepted by existing sched-ext programs.
- Make the MEM_RCU case a positive regression test.
- Use the preferred multi-line comment style.
- Link to v2: https://lore.kernel.org/r/20261005-a3-arg-trusted-v4-v2-0-319ce2936949@mails.tsinghua.edu.cn

Changes in v2:
- Retarget the fix to btf_check_func_arg_match(), where the subprogram
  argument check lives in this tree, instead of check_func_arg().
- Run the check after check_reg_type() and check_func_arg_reg_off() so type
  and offset diagnostics keep their wording.

v1: https://lore.kernel.org/bpf/20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn/

---
Yiyang Chen (2):
      bpf: Reject bare pointer for __arg_trusted arg
      selftests/bpf: Cover bare and RCU __arg_trusted arguments

 kernel/bpf/verifier.c                              | 24 +++++++++++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 34 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
change-id: 20261005-a3-arg-trusted-v4-9d5d9485e5ba
-- 
Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

