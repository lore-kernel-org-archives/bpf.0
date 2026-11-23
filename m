Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463822;
	b=txaI9soYd80lQbdHr2ec2ddKsmReaInMb0+X6RVaMQ7a5/Whtt0goR9WLRi61CPexEPw
	 FI5oPDDNDyx6A7u902N1r1txugjGi1CzM7vajn10IpzONR4eduPTzDioYH+lWTi1Pho2e
	 m9DwXJlqTpeonHPMhBdF6fxkKr//cFAyVJB3EZrw6hzjWLvHcl5EqM1slji7yer0UjPZF
	 ZW0u6RHM2EmysssTGdInlP8qGGA8dElvm4VX5CjxK7XTgQy1jSVFG+7oMlkhcTYa1DU2R
	 rvtcwzx+1ksz15HQx6BCUq9UosQKyb6B9hGiIAySF4IyvDrCK5fz3r+giyS39HATn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463822;
	h=DMARC-Filter:DKIM-Signature:Received:Received:To:cc:From:Reply-To:
	 Subject:MIME-Version:Content-Type:Date:Message-ID;
	bh=gL/q1hOlHUU9eJtG0oeQF4G94S2zh6dlEpg6/FnmiqE=;
	b=lkBfdWWpcCUMkP51zrUUFFeZTo5oa/d5Q1Yck3pPRgo1VkLCCU3OZsFhpclnYnnhjnBo
	 EUqSTbyj0gjsiwUQX5H7BUy43/FOPz0p0PDCFdK64x3qnC7sUQycGo/cIuOF6BsToWpbx
	 Jbh4YNqwR1Qnq1B9FqXu39xgfUEn8adbs80x8yVwRBTjFUQLCZt8eemHpB84V2hx0RVs7
	 lmzDupJolXLh8zdmAeJpENCxGjdx6JOm1VJ0Nkhe0J4XX20Mc9DM+vZ+X4gbFJqumfJxW
	 ozWacN2p3mOoIo3QE/NpxbUusKKq3arZ2ZoJ78ZJkvCxmZhep8MBItt5/hACmvF5ATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=JqKe5LOn;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2E606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC2E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=JqKe5LOn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Content-Type:
	MIME-Version:Subject:Reply-To:From:cc:To:Sender:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gL/q1hOlHUU9eJtG0oeQF4G94S2zh6dlEpg6/FnmiqE=; t=1795463821; x=1796327821; 
	b=JqKe5LOnli2OINwNv2LfCR5GgRSXn6qY4liStqwiTsP5pWqfnVTZsQqK+DoALazFHerntMCYhjH
	c0+0wJ11prf9n9ERCBQq0HdMMYWSaI//ryWLEn1z/0R2nU8gEKzTH2sUZFRKiu4ywXyeXczO5Wf57
	v/xUOt+3orDwQd9MUoXpmgIoTwdPAuQUABQ/+2wAfVPNQVSKMj8d+s0KL0ZJAOYmUJnLNhp//E0wA
	6jveemzr/UE8eHeNOkdu2J1oDd1fnlO/dtYKAb5LtZ0BXc14pxlxW6S6bz3dwxHabA8rCU7IsIsdH
	ba3UwE8SGPoaG3Lerp26hUP8OfXnNMdj0aiw==;
Received: from 30-11-166.wireless.csail.mit.edu ([128.30.11.166])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1xVa9i-006gc4-5A;
	Mon, 23 Nov 2026 14:56:50 -0500
Received: from 30-11-166.wireless.csail.mit.edu (localhost [127.0.0.1])
	by 30-11-166.wireless.csail.mit.edu (Postfix) with ESMTP id D16413FBF5AC;
	Mon, 23 Nov 2026 14:56:49 -0500 (EST)
To: Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    John Fastabend <john.fastabend@gmail.com>
cc: bpf@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: ebpf program can cause verifier crash in check_return_code()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Mon, 23 Nov 2026 14:56:49 -0500
Message-ID: <43917.1795463809@30-11-166.wireless.csail.mit.edu>

--=-=-=
Content-Type: text/plain

I've attached a demo struct_ops / io_uring program that causes the ebpf
verifier to dereference a bad pointer. The disassembled instructions are
below. I believe what's happening is:

  * instruction 6 is a call to bpf_io_uring_get_region(), causing the
    verifier to set r0's reg->type to PTR_TO_MEM|PTR_MAYBE_NULL, with
    reg->mem_size set to the call's 3rd argument (64 in the demo).

  * the conditional jump at instruction 7 goes to the exit.

  * the verifier's check_return_code() executes this without a check
    of r0's reg->type:

        if (prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
                /* Allow a struct_ops program to return a referenced kptr if it
                 * matches the operator's return type and is in its unmodified
                 * form. A scalar zero (i.e., a null pointer) is also allowed.
                 */
                reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;

  * reg->btf shares a slot in the bpf_reg_state union with mem_size, so
    reg->btf is 64, and check_return_code() calls btf_type_by_id(64, ...),
    which crashes.

The attached demo code is suitable for libbpf-bootstrap/examples/c; here
are the bpf instructions (you may need to fiddle with instruction 7's
jump offset; +19 works on one of my setups, while +16 is required on
another):

io3.bpf.o: file format elf64-bpf
Disassembly of section struct_ops.s/loop_step:
0000000000000000 <my_loop_step>:
       0:       79 18 08 00 00 00 00 00 r8 = *(u64 *)(r1 + 0x8)
       1:       79 17 00 00 00 00 00 00 r7 = *(u64 *)(r1 + 0x0)
       2:       b7 06 00 00 00 00 00 00 r6 = 0x0
       3:       bf 71 00 00 00 00 00 00 r1 = r7
       4:       b7 02 00 00 00 00 00 00 r2 = 0x0
       5:       b7 03 00 00 40 00 00 00 r3 = 0x40
       6:       85 10 00 00 ff ff ff ff call -0x1
       7:       c6 06 13 00 00 00 00 40 if w6 s< 0x40000000 goto +0x13 <my_loop_step+0xd8>
       8:       84 02 00 00 00 00 00 00 w2 = -w2
       9:       89 50 00 00 00 00 00 00 r0 = *(s16 *)(r5 + 0x0)
      10:       85 10 00 00 ff ff ff ff call -0x1
      11:       b7 09 00 00 01 00 00 00 r9 = 0x1
      12:       bf 71 00 00 00 00 00 00 r1 = r7
      13:       b7 02 00 00 01 00 00 00 r2 = 0x1
      14:       85 10 00 00 ff ff ff ff call -0x1
      15:       67 00 00 00 20 00 00 00 r0 <<= 0x20
      16:       c7 00 00 00 20 00 00 00 r0 s>>= 0x20
      17:       6d 09 03 00 00 00 00 00 if r9 s> r0 goto +0x3 <my_loop_step+0xa8>
      18:       b7 01 00 00 01 00 00 00 r1 = 0x1
      19:       63 18 00 00 00 00 00 00 *(u32 *)(r8 + 0x0) = r1
      20:       05 00 05 00 00 00 00 00 goto +0x5 <my_loop_step+0xd0>
      21:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
      23:       b7 02 00 00 07 00 00 00 r2 = 0x7
      24:       85 00 00 00 06 00 00 00 call 0x6
      25:       b7 06 00 00 01 00 00 00 r6 = 0x1
      26:       bf 60 00 00 00 00 00 00 r0 = r6
      27:       95 00 00 00 00 00 00 00 exit

The crash backtrace:

Unable to handle kernel access to user memory without uaccess routines at virtual address 00000000000000e8
Current io3 pgtable: 4K pagesize, 39-bit VAs, pgdp=0x0000000084ca3000
[00000000000000e8] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
Oops [#1]
Modules linked in:
CPU: 0 UID: 0 PID: 70 Comm: io3 Not tainted 7.4.0-rc3-00441-g539a78300c41-dirty #843 PREEMPTLAZY 
Hardware name: riscv-virtio,qemu (DT)
epc : btf_type_by_id+0x6/0x40
 ra : check_return_code+0x22e/0x448
status: 0000000200000120 badaddr: 00000000000000e8 cause: 000000000000000d
[<ffffffff80222746>] btf_type_by_id+0x6/0x40
[<ffffffff801c4ddc>] check_return_code+0x22e/0x448
[<ffffffff801dd3f0>] do_check_common+0x2474/0x2af4
[<ffffffff801e0d7c>] bpf_check+0x28f0/0x2b2c
[<ffffffff801b5806>] bpf_prog_load+0x4bc/0x95a
[<ffffffff801b7fda>] __sys_bpf+0x181c/0x25d6
[<ffffffff801b8fc6>] __riscv_sys_bpf+0x1e/0x26
[<ffffffff80b88fbe>] do_trap_ecall_u+0x14a/0x324
[<ffffffff80b97788>] handle_exception+0x168/0x174

Robert Morris
rtm@mit.edu


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=io3.bpf.c
Content-Transfer-Encoding: base64

Ci8vCi8vIHRvIGJlIHJ1bmluIGxpYmJwZi1ib290c3RyYXAvZXhhbXBsZXMvYwovLwoKI2luY2x1
ZGUgInZtbGludXguaCIKI2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPgojaW5jbHVkZSA8YnBm
L2JwZl90cmFjaW5nLmg+CgpzdHJ1Y3QgaW91X2xvb3BfcGFyYW1zIHsKCV9fdTMyCQkJY3Ffd2Fp
dF9pZHg7Cn07CgpzdHJ1Y3QgaW91X2N0eCB7IH07CgpleHRlcm4gaW50IGJwZl9pb191cmluZ19z
dWJtaXRfc3FlcyhzdHJ1Y3QgaW91X2N0eCAqbG9vcF9jdHgsIF9fdTMyIG5yKSBfX2tzeW07CmV4
dGVybiBfX3U4ICpicGZfaW9fdXJpbmdfZ2V0X3JlZ2lvbihzdHJ1Y3QgaW91X2N0eCAqbG9vcF9j
dHgsIF9fdTMyIHJlZ2lvbl9pZCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IHNpemVfdCByZHdyX2J1Zl9zaXplKSBfX2tzeW07CgplbnVtIHsKICBJT1VfUkVHSU9O
X01FTSA9IDAsCiAgSU9VX1JFR0lPTl9DUSAgPSAxLAogIElPVV9SRUdJT05fU1EgID0gMiwKfTsK
CmVudW0gewogIElPVV9MT09QX0NPTlRJTlVFID0gMCwKICBJT1VfTE9PUF9TVE9QICAgICA9IDEs
Cn07CgpTRUMoInN0cnVjdF9vcHMucy9sb29wX3N0ZXAiKQppbnQgQlBGX1BST0cobXlfbG9vcF9z
dGVwLCBzdHJ1Y3QgaW91X2N0eCAqbG9vcF9jdHgsIHN0cnVjdCBpb3VfbG9vcF9wYXJhbXMgKmxw
KQp7CgogIF9fdTggKm1lbSA9IGJwZl9pb191cmluZ19nZXRfcmVnaW9uKGxvb3BfY3R4LCBJT1Vf
UkVHSU9OX01FTSwgNjQpOwogIGlmICghbWVtKXsKICB9CgogIHJlZ2lzdGVyIHZvbGF0aWxlIHZv
aWQgKnIxIGFzbSgicjEiKTsKICByZWdpc3RlciB2b2xhdGlsZSB2b2lkICpyMiBhc20oInIyIik7
CiAgcmVnaXN0ZXIgdm9sYXRpbGUgdm9pZCAqcjMgYXNtKCJyMyIpOwoKICBhc20gdm9sYXRpbGUo
ImlmIHc2IHM8IDB4NDAwMDAwMDAgZ290byArMTkiKTsKICBhc20gdm9sYXRpbGUoIncyID0gLXcy
Iik7CiAgYXNtIHZvbGF0aWxlKCJyMCA9ICooczE2ICopKHI1ICsgMCkiKTsKCiAgc3RydWN0IGlv
X3VyaW5nX3NxZSAqc3FlcyA9CiAgICAoc3RydWN0IGlvX3VyaW5nX3NxZSAqKWJwZl9pb191cmlu
Z19nZXRfcmVnaW9uKHIxLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAobG9uZylyMiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKGxvbmcpcjMpOwoKICBpZiAoIXNxZXMpewogIH0KCiAgaW50IHN1Ym1p
dHRlZCA9IGJwZl9pb191cmluZ19zdWJtaXRfc3Flcyhsb29wX2N0eCwgMSk7CiAgaWYgKHN1Ym1p
dHRlZCA8IDApewogIH0KCiAgaWYgKHN1Ym1pdHRlZCA+IDApIHsKICAgIGxwLT5jcV93YWl0X2lk
eCA9IDE7IC8qIFdhaXQgZm9yIGF0IGxlYXN0IDEgQ1FFIGJlZm9yZSBuZXh0IHN0ZXAgKi8KICAg
IHJldHVybiBJT1VfTE9PUF9DT05USU5VRTsKICB9CgogIGJwZl9wcmludGsoImlvMyAjMiIpOwoK
ICAvKiBSZXR1cm4gY29udHJvbCB0byB1c2Vyc3BhY2UgaW9fdXJpbmdfZW50ZXIoKSAqLwogIHJl
dHVybiBJT1VfTE9PUF9TVE9QOwp9CgpzdHJ1Y3QgaW9fdXJpbmdfYnBmX29wcyB7CglpbnQgKCps
b29wX3N0ZXApKHN0cnVjdCBpb3VfY3R4ICosIHN0cnVjdCBpb3VfbG9vcF9wYXJhbXMgKmxwKTsK
CglfX3UzMiByaW5nX2ZkOwoJdm9pZCAqcHJpdjsKfTsKClNFQygiLnN0cnVjdF9vcHMubGluayIp
CnN0cnVjdCBpb191cmluZ19icGZfb3BzIG15X3VyaW5nX29wcyA9IHsKICAubG9vcF9zdGVwID0g
KHZvaWQgKilteV9sb29wX3N0ZXAsCiAgLyogLnJpbmdfZmQgaXMgcG9wdWxhdGVkIGZyb20gdXNl
cnNwYWNlIGJlZm9yZSBsb2FkaW5nL2F0dGFjaGluZyAqLwp9OwoKY2hhciBfbGljZW5zZVtdIFNF
QygibGljZW5zZSIpID0gIkdQTCI7Cg==
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=io3.c
Content-Transfer-Encoding: base64

Ly8KLy8gdG8gYmUgcnVuIGluIGxpYmJwZi1ib290c3RyYXAvZXhhbXBsZXMvYwovLwoKI2luY2x1
ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5j
bHVkZSA8bGlidXJpbmcuaD4KI2luY2x1ZGUgPGJwZi9saWJicGYuaD4KI2luY2x1ZGUgImlvMy5z
a2VsLmgiCgppbnQgbWFpbih2b2lkKQp7CiAgc3RydWN0IGlvX3VyaW5nIHJpbmc7CiAgc3RydWN0
IGlvX3VyaW5nX3BhcmFtcyBwYXJhbXMgPSB7CiAgICAuZmxhZ3MgPSBJT1JJTkdfU0VUVVBfU0lO
R0xFX0lTU1VFUiB8IElPUklOR19TRVRVUF9ERUZFUl9UQVNLUlVOLAogIH07CiAgc3RydWN0IGlv
M19icGYgKnNrZWw7CiAgc3RydWN0IGJwZl9saW5rICpsaW5rOwogIGludCBlcnI7CgogIHN5c3Rl
bSgiZWNobyAxID4gL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfZW5hYmxlIik7CgogIGVyciA9
IGlvX3VyaW5nX3F1ZXVlX2luaXRfcGFyYW1zKDMyLCAmcmluZywgJnBhcmFtcyk7CiAgaWYgKGVy
ciA8IDApIHsKICAgIGZwcmludGYoc3RkZXJyLCAiaW9fdXJpbmdfcXVldWVfaW5pdF9wYXJhbXMg
ZmFpbGVkOiAlZFxuIiwgZXJyKTsKICAgIHJldHVybiAxOwogIH0KCiAgc2tlbCA9IGlvM19icGZf
X29wZW4oKTsKICBpZiAoIXNrZWwpIHsKICAgIGZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIG9w
ZW4gQlBGIHNrZWxldG9uXG4iKTsKICAgIGdvdG8gb3V0X3Jpbmc7CiAgfQoKICBza2VsLT5zdHJ1
Y3Rfb3BzLm15X3VyaW5nX29wcy0+cmluZ19mZCA9IHJpbmcucmluZ19mZDsKCiAgZXJyID0gaW8z
X2JwZl9fbG9hZChza2VsKTsKICBpZiAoZXJyKSB7CiAgICBmcHJpbnRmKHN0ZGVyciwgIkZhaWxl
ZCB0byBsb2FkIEJQRiBza2VsZXRvbjogJWRcbiIsIGVycik7CiAgICBnb3RvIG91dF9za2VsOwog
IH0KCiAgbGluayA9IGJwZl9tYXBfX2F0dGFjaF9zdHJ1Y3Rfb3BzKHNrZWwtPm1hcHMubXlfdXJp
bmdfb3BzKTsKICBpZiAoIWxpbmspIHsKICAgIGZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIGF0
dGFjaCBzdHJ1Y3Rfb3BzXG4iKTsKICAgIGdvdG8gb3V0X3NrZWw7CiAgfQoKICBzdHJ1Y3QgaW9f
dXJpbmdfc3FlICpzcWUgPSBpb191cmluZ19nZXRfc3FlKCZyaW5nKTsKICBpb191cmluZ19wcmVw
X25vcChzcWUpOwogIGlvX3VyaW5nX3N1Ym1pdF9hbmRfd2FpdCgmcmluZywgMSk7CgogIHN0cnVj
dCBpb191cmluZ19jcWUgKmNxZTsKICBpZiAoaW9fdXJpbmdfcGVla19jcWUoJnJpbmcsICZjcWUp
ID09IDApIHsKICAgIHByaW50ZigiQ29tcGxldGVkIENRRSByZXM6ICVkXG4iLCBjcWUtPnJlcyk7
CiAgICBpb191cmluZ19jcWVfc2VlbigmcmluZywgY3FlKTsKICB9CgogIGJwZl9saW5rX19kZXN0
cm95KGxpbmspOwogb3V0X3NrZWw6CiAgaW8zX2JwZl9fZGVzdHJveShza2VsKTsKIG91dF9yaW5n
OgogIGlvX3VyaW5nX3F1ZXVlX2V4aXQoJnJpbmcpOwogIHJldHVybiAwOwp9Cg==
--=-=-=--
