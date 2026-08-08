Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E932233947
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151830; cv=none; b=MXTIXXYbf9kTScYMUDgTbtIyyRC0UWmncm9qkt5/BLcItnu9LEu5XQsJVpw6FxonKti/Ho3E9egebFKMrVv7fAvhn7qaYZqoWjhqNIVVwtV5ijUUNz85EikOI0JsveodHm7Rmz3NsiWaiDr9/lgxHDUOfciD6yIzylmiOjy+Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151830; c=relaxed/simple;
	bh=/LRpiM1joED2rL0FVf3OZn7bIS6XhhjnXAveXfUsFIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SDafhZZWsi91mdzsbJie73bIewYbaj9SMZb1YA8c/LDtERZm0mEnhBtkyIWVpWZgHc5iZlGLpx/c557F8+sBJqgTxLpZZraCYk6g4nm3BVvGUAYPvZyN1aWsitY5n2Q2Z4MmiZnkjISjx1GwJccSbk+MQh4P97LQBx64UPHnw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTFZ2AVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTFZ2AVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB51F000E9;
	Sat,  8 Aug 2026 01:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151829;
	bh=/LRpiM1joED2rL0FVf3OZn7bIS6XhhjnXAveXfUsFIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTFZ2AVXg3b71bCUZbvmyWML/8mUDpTKDP5rUIoONjSQA08S2YGaSvq27BjlkSA8+
	 VYwfnCVLg8FcbjhUouYdXT+fj6nvVTN7pKlBNkoeFcpaXHlu51KQLt97UnllnSNb+r
	 yB/8oVEI2Bi0rBOOtbqI6FhV0aqq9EFlUisywNwTVzKCe3+hSRy0U9MjRTpT3CxTmg
	 +GAFUZhVdXv49BxY3mawXaIbzBkdVsNMaU/bTGM4HMplOd7cy2/97onxAmvfJ148he
	 puvlPD6ArOvovE1KjCFMpqNEOBGCo4HaS99tywkg6ECYhWQNSywSvGg7MCnDAsjVxK
	 jyFWcFT2FmizQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Support __arena and
 __arena__nullable on struct_ops arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808003938.3486067-6-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
 <20260808003938.3486067-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 01:17:08 +0000
Message-Id: <20260808011708.EEBB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Attaching an extension (freplace) or tracing (FENTRY/FEXIT) progra=
m to a struct_ops program with arena arguments bypasses arena context argum=
ent verification, leading to type confusion and potential privilege escalat=
ion.
--

--- Patch [5]: [PATCH bpf-next v5 05/14] bpf: Support __arena and __arena__=
nullable on struct_ops arguments ---
commit b8ab49b96186f2dfd00ae0e67ee1912d4b9e3fac
Author: Tejun Heo <tj@kernel.org>
bpf: Support __arena and __arena__nullable on struct_ops arguments

This commit adds support for __arena and __arena__nullable suffixes for
arguments in struct_ops stub functions. It allows callbacks to receive
arena pointers directly, with the trampoline handling the conversion between
the kernel address and the BPF arena pointer.

(Note: The format of this report is altered to use a free-form summary
rather than inline diff quotes due to recitation restrictions.)

[Severity: High]
There appears to be an issue in how __bpf_trampoline_link_prog() checks
for arena arguments when linking programs. The security check evaluates
bpf_prog_has_arena_ctx_arg(node->link->prog), which checks the attaching
program rather than the target program (tgt_prog).

Because the attaching extension or tracing program does not have its
ctx_arg_info_size initialized (it is 0), this check is bypassed and the
attachment is allowed.

Furthermore, during verification of the extension program in
btf_ctx_access(), the verifier loops over ctx_arg_info_size. Since it is
0 for the attaching program, the loop is skipped. The verifier then
incorrectly types the 32-bit offset argument as a trusted 64-bit kernel
pointer (PTR_TO_BTF_ID) based on the original BTF signature.

At runtime, the struct_ops indirect trampoline converts the incoming kernel
pointer into a 32-bit arena offset and invokes the extension program. Since
the verifier sees this as a trusted kernel pointer, could this lead to a
type confusion where a user-controlled 32-bit offset is dereferenced as a
kernel pointer?=20

Should __bpf_trampoline_link_prog() check tgt_prog instead, and does the
verifier need to inherit or check the ctx_arg_info of the target program
for extension programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808003938.3486=
067-1-memxor@gmail.com?part=3D5
