Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827450;
	b=aBy6GoNKlS1hatYbon21KMohNw3en2C/ZjDNQfJK3lpKIjIN326B7bRb+Mkoi1WvF83e
	 sbll9/4HwDS/GGlOODHacAohqqYEMIvjUQSErJTShUcx3Mc7jS7kArzt5iUmY76TM+Fwt
	 ovLTwCe/U5h1WOcWQ2HxEnSZKlMS6MeyzZD4qK7exeXG32Lr1omFoARZtoRCd7VcP1RzE
	 oUMr+RfCJZxExra/Kk6sOYvLKdi0x5zCwius3Gh/BWzeBsqN7vYYjLpW7NLs1hAv2hjXB
	 UmppP/o8CLxnT4/OjEYTBzS7t1MkWoke6/QNJ2+q9wMCQ0hGntrHON7ewX0EmJ1ykZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827450;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=NiKIO0+gHf2u0X3ei2M2noY8Ivx3JPmLwxx5fcklIfk=;
	b=IqrsheTJmKKVgQlktkp3vm3Rw4VOUnid6kEbDNTlmD0BAS9T8bvEe2/HLBnfRqtAsEpS
	 l5cTfF806fgNMjG0nYivPIW0FW8KCtkgNk5k/+PZBSW/qqqBle7JyL4Dwa3GiZdLiqKMo
	 oMUrpUvUOqrjmLkmlLscN5w3FkH9m+xNk7IlRN5gWMmCibhP2V1fDLRXRH0tOARwJeg5f
	 gojqkKC4k++1yqyNJuuFTMJNadtQaeWzHwAO8dE8z9iSr86dKr03FkyoQrg4UkHYL1YqF
	 lwdv2q6LDo2QfsVpAc2i/3bVVFHxpLsm5YhqUzMMz8SdtQiNElsNWG4Bce7wbxcrZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U0yZYDm8;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB53606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 07:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U0yZYDm8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=NiKIO0+gHf2u0X3ei2M2noY8Ivx3JPmLwxx5fcklIfk=; b=U0yZYDm8BEuCPLH1YdZzkiwirA
	PXNiG76ZXcnQO9Ay01o7ToztepEVnKwKx48GgKr2Vh9n5xpyr+N9XZj7qMSnypuDrzPu9FqEpEPYB
	V7cvW/wHf91AUZ058o6dbgOQa8OMVkTD179BIsDShM+o+/cyQtHSMK3FLMJHLRbGjdiDZYOy6+ecZ
	FEmKm8OzDP7sBSk5CJyGIuOeWtWVFVvAMy0SuayYEke7ibehKQg8yWi79k+dYMapT/sHizAS7oF33
	Q7ldGtfELUuG1MoT2PVoQKo8CQEItNMl3yWjJ0D04CCuwC7AuhqXJtPmj2Lz3iLCzM86vw4Q3bAV4
	h8zUA++g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xKWJV-000MYj-0J;
	Sat, 24 Oct 2026 09:37:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH bpf 1/2] x86/ftrace: Use jmp mode only where functions are aligned
Date: Sat, 24 Oct 2026 09:37:11 +0200
Message-ID: <20261024073712.1074591-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28162/Fri Oct 23 08:24:08 2026)

Since commit 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
ftrace_call_replace() emits a jmp instead of a call when bit 0 of the
target is set, the mark of a direct trampoline that is entered by a jmp.
ftrace_update_ftrace_func() and arch_ftrace_update_trampoline() use it
too, for the call of the ftrace callback in ftrace_caller, ftrace_regs_caller
and the ftrace trampolines, but a callback is a C function and can start
at an odd address. It does with gcc13 and CONFIG_CC_OPTIMIZE_FOR_SIZE=y:
gcc13 has no -fmin-function-alignment, so CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
is not set, and the -falign-functions=16 used in its place does not apply
to functions optimized for size. Here ftrace_ops_list_func() starts at:

  ffffffff810e0147 T ftrace_ops_list_func

ftrace_regs_call then becomes a jmp to the byte before it:

  ftrace_regs_call ffffffff810374f3: e9 4e 8c 0a 00

That byte is the last one of the preceding function's tail jump, and with
the first two of ftrace_ops_list_func() it decodes as an inc DWORD PTR
[rcx+0x57], which swallows the push %r15 of the prologue. Entered without
a return address and one push short, the list function returns through
the pt_regs that ftrace_regs_caller saved, here to the saved R14:

  BUG: unable to handle page fault for address: ffff888116c29f40
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0xffff888116c29f40
  R13: 0000000000000000 R14: ffff888116c29f40 R15: 0000000000000000
  Call Trace:
   ? bpf_trampoline_6442499918+0x1/0x149
   ? bpf_lsm_file_open+0x5/0x8
   ? bpf_lsm_file_open+0x5/0x8
   ? security_file_open+0x19/0x46
   ? do_dentry_open+0x16c/0x32a

The list function is installed whenever two ftrace_ops are registered,
and a function that two of them trace calls it. A kprobe next to a BPF
trampoline is one such case, and with the single ftrace_ops of the BPF
trampolines every update_ftrace_direct_mod() is another, as it registers
a stub ops for the sites it modifies. Here, detaching one of several BPF
LSM programs from a busy hook crashed the tasks that ran the hook during
the update.

Bit 0 has that meaning only for the direct trampolines that a dyn_ftrace
record can point to, so jmp mode relies on every other target being even.
Select HAVE_DYNAMIC_FTRACE_WITH_JMP only where it is, with
CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT or without CONFIG_CC_OPTIMIZE_FOR_SIZE.
arm64 does the same for HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS, which depends
on function alignment as well, but tests CONFIG_CC_IS_CLANG instead of
CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT, which also covers gcc 14 and its
-fmin-function-alignment. Other builds use the call mode for BPF
trampolines, as they did before that commit and as a trampoline sharing
its site with an IPMODIFY ops still does.

Fixes: 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Menglong Dong <dongml2@chinatelecom.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3907f2f3d5b1..56118fcf036b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -232,7 +232,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
+	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64 && (CC_HAS_SANE_FUNCTION_ALIGNMENT || !CC_OPTIMIZE_FOR_SIZE)
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
-- 
2.43.0

