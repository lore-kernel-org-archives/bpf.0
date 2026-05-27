Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE0360EE9;
	Wed, 27 May 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909996; cv=none; b=hemA+VVRslV7Dd2Wh5OXOkVE3/rYZdPx23XWklQYp4OwzwmF4A/A0VwL/dEl+W6TBa/TmKHC18SrpDXU7pRcV2dauk3WwQSrD149B6IETeFUWeO+rs7V46CVi6RrvkXjux1dhzaa+5HqcGK8Nq/7FEZffaKO9826GyVNSxGT7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909996; c=relaxed/simple;
	bh=NacFeoUiDyV+81hoWhXoPmraVt3gh/ZYf2FO2EoHfVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eob8U/eoRgP+9rDrCAcD9Ba2z6abVIYb9ss/9ALVFQzOa2cfcfhFOZ35yDa+6A4V85TOcxvsDrr5yrmTrjmlXXnwTJ0qltQbezczlAoDEUEMhy2KyHgH+9TS/A9CZyzwLUZ+EQfIiVEgPyDgEz10jqKw1l4r3sIg57Ux4AH1Z4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooUOGkXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooUOGkXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ABF1F000E9;
	Wed, 27 May 2026 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779909993;
	bh=BwlpQRqk9XfvOd4PhAqbHcllY/jpg30AY0aMEuokYf8=;
	h=From:To:Cc:Subject:Date;
	b=ooUOGkXe3/5kwsPnVTxC3EpA+rL5Kj+9jpsM4MSWszQQyVexllNacqZZqwocIzbkl
	 DlzBhD4/MtejM9lfY3h3J/yvf5eq6qJ9fWIcCGQVq+MJcJ3GHKLVcbqymgAV0Xu5J2
	 /Kd6lRIX1u0unozdLFZHFncBNt8etRQSX9VWK6p1QHB2yRpzE3HX1+DXA8OcZ0nS2k
	 idp1g4E8op/mInog3q2njuzAHZHoqWwCzRX2Avhgau0oo2ICbsVzzXdYJMXcvoxJne
	 udrteNr8FchHoyCtVbx94sRkpyI87At6CAzSTfRxMEj3lLsiNkddLdqwJCKNg4nH77
	 ioWg6ZUwTyVcQ==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix bpf_arena_handle_page_fault() redefinition without CONFIG_BPF_SYSCALL
Date: Wed, 27 May 2026 09:26:32 -1000
Message-ID: <20260527192632.2109419-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On configs with CONFIG_BPF=y but CONFIG_BPF_SYSCALL=n (e.g. arm
multi_v7_defconfig), kernel/bpf/core.c defines a __weak
bpf_arena_handle_page_fault() while bpf_defs.h already supplies a static
inline stub for it, causing a redefinition error. Build the __weak
definition only under CONFIG_BPF_SYSCALL, matching the bpf_defs.h
declaration and the CONFIG_BPF_SYSCALL-gated strong definition in arena.c.

Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8ecba2989d88..a656a8572bdb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3376,13 +3376,14 @@ __weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 {
 	return 0;
 }
+
+#ifdef CONFIG_BPF_SYSCALL
 __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
 					unsigned long fault_ip)
 {
 	return false;
 }
 
-#ifdef CONFIG_BPF_SYSCALL
 static int __init bpf_global_ma_init(void)
 {
 	int ret;
