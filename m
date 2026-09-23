Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B940D574
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190281; cv=none; b=m4GeUNDTxfzxfePj49cuxZaGlXIVqdu2u2AR2QcxlMzUkkpZ6q7m0h/nXwXi6h8PtI7dIqvU8iyGaud1RooamJZPxG/nTGCwCRS0rtg7t2pNn2WVdbpKO/nBYoin+1hX24F4tPG23wyYffKM4Vgdqs3WnZsqo0ecFzij1apaVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190281; c=relaxed/simple;
	bh=ryybatrzYt9LT7OaKL2Whui0+i49SQsjuUujcoxK5rU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcIcKQXQSfELpLWbRsJyvME1xVsWbYvzGikbC0SvQZhzwPt/oGRq4X7lWuC16sa+YcNr5zIArYzWBJdjEJQOx91uku/slMcf0d3+inU59sdK2+w1O5hWuHhhA+5TksVK1he0+PFWxhT07WvweKPVVSXtUHtpXkXpz/sMInk7nXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNCXbir9; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNCXbir9"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd05d97dso975502c88.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190279; x=1790795079; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3HosMgCPzH/OnPquvHJANu2Jt5Je4cvogIi8fRx8Oos=;
        b=dNCXbir91ZisjKNW/OydoFVsFaPyfPvHsMHwrqErj0jYe77/eObBzHnYS/ZhUE8lgY
         u5D6WJzNOpqKCmzq1Pj7FwtQuYeSFyowlLvX5XkfrSRM5XPMl+GctPbfHnezk/7PTF+p
         a19pbkX+PLoI8AfkRtdZ3lE4SgbMDrFhdz62DoyRxsVqbcVol9vtCWYLGSCyDtms7Pmo
         A2Gvva07z1+lEC2bo30VM0lJ3Gvvyf7QnVZz+s7OYzpwAPFmpwIy/Wz8RJ62gMQMrlv0
         ysEuaL/CNnrk+lA91SXZdCW/8Rr0i0WwJufbLUhiUISyDxxq5aYtZGKppehJ1t+vX+cc
         I9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190279; x=1790795079;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HosMgCPzH/OnPquvHJANu2Jt5Je4cvogIi8fRx8Oos=;
        b=LliihpQVkDVVaaE4EOBuiz3+Bmc07kqOkEM962umAQXw77D7AVJNryVTmulUUo1+Qw
         vhX2O5QpPuEPbWqeMTpAt0GFX2W0+Q6kvEpc6D2GQvDJnOrbbg5RY9TiMIKs8mbtQT8C
         PV2PJzA6vFidsY1LDD02c/40qF/4ctzw4RtcC+/4k3fw8WsachzbVodj6PbguVOrBwAr
         y5Vpy56gpvSmSO+CDE9IOt95lCu02XQzBV0l3fqXPeaLKDgKNzCHSs8NVQOlu1RDnK3b
         zUY5kf0lShbddHd2QfhN4BKiJJv6T2I+vGmF3anWZb884caiqrVa0RyM1SmS6xdlqZHR
         qo8Q==
X-Forwarded-Encrypted: i=1; AKwUvByWfVf/vl93DQi9uYuaJRqP4i5cA7cUnelZ3GC+2j0ql2aOxYxiRx3PR44iieheXWYIz+A=@vger.kernel.org
X-Gm-Message-State: AFuF++l6TwemSM6wYpWj1omz+cTq49d5G4+6cQbl5LmRNfUrwGdoMrY0
	Yht37BQ/xBnzwhikpZFPT0Ie0mMgYVRnwQjnAwww4MzV3GYDxmPlQ3nX
X-Gm-Gg: AYBFou2qoCR91hFVfeNSOU+p1QvdOM3MOmuan6+q50oibvtxhzH2c0bWrw54kNxSX4t
	caTh8wJ7hJEycP9JiaqrdPoEDaNsGq6OW5kp62QiQYexiz6fK+FvqqH0XnOQZMAElK8vN0PAxRW
	SvONO9RkUfn/TAWy6j+zJgS8hByh8+qhmTFPZLMjiv5rMOkv/a7t0pbk7CXEjSYPDxlx4qgm9jp
	HS/QlCwwko37Pk1SBWcdhg4vjfSGRgFtlAFBJFIiNf3WAiUFhrVWwCBVhGGBHEdqG8tUZfCluGS
	m/7RJvsY+7HgRxqDjCti7c9mWL2ysEAR15+UySLIPBp2/BTAaoC0tLklXCfRrFrt9cEqp8kDZTb
	hIpv0LcgsUyxVnzR3BmK1B3I/z18mlmo2n1pFjxhcGcl0W8TPKjGuTtbokK1dziKHt7Yi8PVm/w
	PJStyw7b5xhGW2uAHyW3mFsySNkcFRNNGbXdnfF17yGg+DORDVk3jYSemRVW6dhkFz2VX7KcFK6
	n/CkhGWyGLtxl4aziHXHXc2O1ARdSALZNoam4cpeTBJ3ODKW0V9V6v0naAcklfajS7y
X-Received: by 2002:a05:701b:204e:20b0:13b:3c3b:8dbb with SMTP id a92af1059eb24-14503fde4famr80769c88.23.1790190278923;
        Wed, 23 Sep 2026 12:04:38 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9390183sm6889953c88.0.2026.09.23.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:04:38 -0700 (PDT)
Message-ID: <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 12:04:36 -0700
In-Reply-To: <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
		 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
		 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
		 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
		 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
		 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
		 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
	 <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 17:04 -0700, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 23:37 +0000, Alexei Starovoitov wrote:
> > On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
> > > On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
> > > > On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
> > > > >=20
> > > > > Total size of executable sections for all Meta BPF object files u=
sed
> > > > > for CI veristat testing is 10Mb. Of these there are 30K non-helpe=
r
> > > > > call instructions in total.
> > > > > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst=
 case.
> > > > > Note that the instruction encoding optimized for size already hea=
rts
> > > > > us in src/dst registers department: we have no room for virtual
> > > > > registers, which would have simplified e.g. register allocation t=
ask
> > > > > for ARM64. Point being that optimizing intermediate IR for size i=
s not
> > > > > always a right target.
> > > >=20
> > > > I wasn't talking about increase in bpf ELF size,
> > > > but the amount of the verifier work necessary to double the number
> > > > of call insns.
> > >=20
> > > I don't understand what you mean by the amount of the verifier work.
> > > Traced program paths would remain the same, only the encoding of the
> > > information about exceptions changes.
> >=20
> > Any new insn requires plumbing through out.
> > imo ld_imm64 encoding FD inline was a mistake.
> > We should have went with relocations through out.
> > Much cleaner to extend.
> > Same philosophy here. Landing pad is a metadata.
> > It's not a good idea to encode metadata into assembly instruction.
> > bpf ISA is not a high level IR.
>=20
> Here [1] is Yonghong's series repackaged by codex with the following
> encoding:
>=20
>   call <subprog-or-kfunc> // regular encoding
>   unwind <label>          // a new instruction that must follow the call =
instruction
>=20
> The amount of the verifier/libbpf code dropped from ~2K to 1K lines.
>=20
> [1] https://github.com/eddyz87/bpf/tree/unwind-postfix

I want to highlight this once more, before it gets buried.

Whether landing pad is metadata or not is a matter of opinion,
seeing the program CFG from it's source w/o a need to consult
additional tables is definitely a plus.
Same with ld_imm64, and yes it adds a few checks in the verifier,
but those checks are trivial.

I looked a bit at what other VMs/IRs do and it's a mix:
- JVM has exception tables similar to ours (begin, end, landing-pad).
- GCC (gimple and rtl) have landing pad address attached to an
  instruction / control flow graph node.
- LLVM has invoke instruction that takes three parameters:
  what to call, where to jump on success, where to jump to unwind.

With that in mind, I think that the rational thing to do is to choose
based on the implementation complexity. Compared to v5 [2] of this
series the branch [1] allows to forgo:
- UAPI to copy the cleanup table from user space (patch #2)
- insn_aux_data changes for cleanup_pad address (patch #4)
- simplifies check_cfg() handling (patch #5)
- simplifies main verification pass (patch #9):
  - throw raises unwinding flag
  - varifier interprets `unwind` as any other instruction,
	jump if unwinding, fallthrough during normal operation.
- dramatically simplifies libbpf part, dropping patches #16,17,18:
  - no need to collect cleanup tables from elf
  - no need to relocate these tables
  - no need to pass them to the syscall

> bpf ISA is not a high level IR.

Well, BPF evolved as x86 in disguise and it was the right choice for
that moment in time. Today it is a limiting factor, just talking about
explicit stack vs SSA, it makes it harder to:
- do liveness analysis
- do range analysis
- do SCEV analysis
- use full set of registers on e.g. ARM
- the fastcall implementation is a hack

So, BPF not being a high level IR is not necessarily a good thing.

[1] https://github.com/eddyz87/bpf/tree/unwind-postfix
[2] https://lore.kernel.org/bpf/20260923045846.2414643-1-yonghong.song@linu=
x.dev/
