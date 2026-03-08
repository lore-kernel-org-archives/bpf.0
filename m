Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7E357737
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772957551; cv=none; b=FxAEHXM0GBVfgMMMe780LfgHGV6xO8UA/ximnVHA5Vo45DWJuPeQx0dcODEQ+76nTlJ3GzpTsrQNMBS2GaljRqGne/m9H0COUOXKCjinasVhZKFDSe1Phv40ZMQ+ii4cJTQbNrRqJpas74ew855GiVRI724uyvfEFUxT5g3AnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772957551; c=relaxed/simple;
	bh=0kPwlAt1NxLAxL28LbMMVyiFMI4P+nR8LU78U7/l6Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itzFOdyxdGtEn65z7BzjNxy4HJi4WOSEoEZlkUKg1pHZ9EisvZmP1T49tnXATU0V/x6RSOTQ55myKtnJobzKmsLZ2A+OTkzQkKx3C7UN72i47qfG0P5h6TxFMa17dPAJEnRhntPGohK4D9SNr3zKR8M3QbU2WPuEjC94/E7l3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbQ1ckEk; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbQ1ckEk"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd71fb9f06so106202485a.2
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772957548; x=1773562348; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UyBC5lPUdaSmDiWbOjXi4rnuiWVOWt18d1AlaJG5YLU=;
        b=gbQ1ckEkeQSXT0TbAiX6sbLL68MDp8ZaB/lP07ATUuV9/kbxKt4gicoTmpyvQigQSG
         L7avTurspenZfKwz2798Y2BoRSVGiSocwDEgzmBBoi40uBVpMAvHHx65Bvj6PLKKps9h
         t3I6NB3rp5b4tdJVHtiz0trLd3mh5j72DVtSTtF5toZgVniPD6tH/AT11l5NSuA6K6Ay
         AGEDWC3Vdzm2W6XFwZy/KtfpkvII5mpxvyF57XCoFGvjySVpcHF3OcU6GyGX04dzNAls
         iqso7awVViDT7xhxaaTduHQNkQ2Xkqd+XXqOJxpNCKEYQwx46d670PolXUzWwm0+g3RI
         duaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772957548; x=1773562348;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyBC5lPUdaSmDiWbOjXi4rnuiWVOWt18d1AlaJG5YLU=;
        b=f7v6wmrfTKQJ+xV69Bo6x4ikgCnRQjCbaPsUf+G3kvr5gMyGKTKNGuGLESI93ZK7g7
         +MPxgqDLQt4PtJFBBlKr26GiwUQhODzGqJBdEvGzkJN5tKU24mK/3bxjF+vR91Ko76Qe
         NYqA7uPrH9qG0L8poGYODRPR21S6CHi4JAfahMiwXBlYpAn7Fx1WGK7ivX+A2iixmoKf
         ILdUzZXqlNcVQig0RUjOnPOMhjwMtD1PlRdLLf/dVA5KPBQnx8BX5s+l4hdiwje8Ur+n
         YFzH3K9JG77TQqPmkftrMTb1yQbp3mxDzUpq65BboeKWPK9Sc8GBXNx6/76Q8Uh19RBO
         Ayrw==
X-Forwarded-Encrypted: i=1; AJvYcCV0PzCHF/xlZuYeJcQxui2ifQmgV607mahdEgP3+MI5PhC82x8B9IhzdZiq6+j2AizZWc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsG0GQGy8TlbiPfeegDTp7dEAgi6T2c0dU2bnZtRqpgHCYpI6
	zeP5IP+vm8opk2SwxspSoNYdrM9sMFdmk3vli9TygBihDaD2xPwdbbFzyWChUw==
X-Gm-Gg: ATEYQzy5rJHJ5EwcTXR/IPgMK1ebaXduZsgQZzj4hsH1hAv/2Lr71uy/iN4EbB+prws
	jv7mwqdftN12+5kQLx11WOGuLCz7Ei7ID3zRtkfKFeirQsH4WEC0g6Tc+J6e/+5fg/wfDfAl+E/
	AKSDmWO6R9bluhwVGGP2mA+gNvYKx+e0a7rFy9cAP1sjoMHKkFi6IewvH0hsUjrTXjm1HXRcfxy
	TLhkMgHgNL0oLFQppXMj+MsGFxLN35xadTLjSvL82N7h8IfZfEdVlji/qp2snbSZfHjl4KZ9nDp
	oXUSqpX9R/Y+n3SyiZzRYBpXrRNInwQz1SEys7nePC6j+JWT7RCidAHb2uBWQKODqYxtwByUzW3
	41q/PG1HlAxWbLaQLHxf53pM4Sh03170Id4jXAu3PyD8j7YKu1PBTt1eHDJpHrsmDmO5goNWeJB
	Sy+zEFAFT0LcHIFN2ujem3QfRx1rof7lbpiOZDUF1l1HQHxFXxyjkJeJFc5DkLMQ==
X-Received: by 2002:a05:620a:2a15:b0:8c3:650d:577e with SMTP id af79cd13be357-8cd6d3258c6mr871197785a.4.1772957547466;
        Sun, 08 Mar 2026 00:12:27 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f53bf4esm524182285a.26.2026.03.08.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 00:12:26 -0800 (PST)
Message-ID: <b45c98d4e59bb31c3101d6ae2ef5d7cee8b4f6c8.camel@gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in
 verif_scale_pyperf600
From: Eduard Zingerman <eddyz87@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
 "open list:KERNEL SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Date: Sun, 08 Mar 2026 00:12:22 -0800
In-Reply-To: <CABFUUZGV7ZAVY=Y6Py3ytZUzZV0i9otPWADgP9HtVrDzf612ew@mail.gmail.com>
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
	 <aar9gzh7QVhezeII@Tunnel>
	 <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
	 <CABFUUZGV7ZAVY=Y6Py3ytZUzZV0i9otPWADgP9HtVrDzf612ew@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-eURiOfxFdEHNhEJV5wZ3"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-eURiOfxFdEHNhEJV5wZ3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-03-08 at 13:55 +0800, sun jian wrote:
> On Sat, Mar 7, 2026 at 12:23=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM Paul Chaignon <paul.chaignon@gma=
il.com> wrote:
> > Sun Jian,
> > I asked to do a _minimal_ tweak to pyperf600.
> > What you did is a drastic change. Pls don't hack tests
> > just to make them pass. The tests have to be meaningful
> > and test coverage shouldn't degrade.
> >=20
>=20
> Hi Alexei, Paul,
>=20
> I spent some more time looking into this.
>=20
> Comparing unmodified pyperf600 bytecode between clang-18 and clang-20, I
> see fewer instructions with clang-20 and nearly the same number of
> branches:
>=20
> clang-18: 90134 lines of disassembly, 6090 gotos
> clang-20: 78369 lines of disassembly, 6085 gotos
>=20
> So this does not look like a simple program-size increase. What seems to
> change is the branch layout in the unrolled loop body, which seems to
> make the verifier DFS go deeper before pruning.
>=20
> One useful data point is that a single __on_event() copy does load
> successfully (that was my v2), while with 2 or more copies it
> consistently fails at exactly 8193 jumps. In other words, the verifier
> hits the jump-sequence limit before reaching the second copy.
>=20
> I also tried a range of source-level mitigations, but so far I couldn't
> find one that preserves the test intent and keeps pyperf600 comparable
> to the other variants:
>=20
> - UNROLL_COUNT tuning: 99 does not compile; 100-120 compile but still
> fail at 8193; 121-145 fail to compile; 146-150 compile but still fail
> at 8193
> - early break/goto on !frame_ptr: insufficient for pyperf600, and also
> hurts pyperf600_nounroll by adding branch points to the 600-iteration loo=
p
> - wrapping 5x __on_event() in a non-unrolled loop: verifier still unrolls=
 it
> - making get_frame_data() __noinline: still fails
> - moving the unwind loop into a __noinline subprog: still fails
> - SUBPROGS / __on_event as __noinline: still fails; codegen changes,
> but the verifier still hits 8193
>=20
> Paul also mentioned trying STACK_MAX_LEN/UNROLL_COUNT and only getting it
> to work with STACK_MAX_LEN reduced to 180, which would make it too close
> to pyperf180.
>=20
> The only source change I found that passes is reducing __on_event() to a
> single copy, but that clearly weakens the test as pointed out.
>=20
> At this point, I don't have a source-level fix that preserves the test
> intent.

Hi Sun,

I have an old investigation for the pyperf600 failure reason from March 202=
4.
Attaching it to the email. The discussion happened off-list.
The source-level "mitigation" I found back then still stands:

  --- a/tools/testing/selftests/bpf/progs/pyperf.h
  +++ b/tools/testing/selftests/bpf/progs/pyperf.h
  @@ -97,8 +97,15 @@ static __always_inline bool get_frame_data(void *frame=
_ptr, PidData *pidData,
                              frame_ptr + pidData->offsets.PyFrameObject_co=
de);
  =20
          // read data from PyCodeObject
  +#if __BPF_CPU_VERSION__ < 4
          if (!frame->f_code)
                  return false;
  +#else
  +        asm volatile goto("if %[f_code] =3D=3D 0 goto %l[has_f_code];"
  +                             :: [f_code]"r"(frame->f_code) :: has_f_code=
);
  +        return false;
  +has_f_code:
  +#endif

(One needs cpuv4 because of the jump instructions exceeding 16-bit
 offset ranges are only possible with cpuv4).

The decision back then was that the "mitigation" is too brittle to
apply and we should leave the test as-is, hoping that verifier would
get smarter some day and be able to load the program.

Best regards,
Eduard

--=-eURiOfxFdEHNhEJV5wZ3
Content-Disposition: attachment; filename="old-pyperf600-investigation.md"
Content-Transfer-Encoding: base64
Content-Type: text/markdown; name="old-pyperf600-investigation.md"; charset="UTF-8"

IyBXaGF0IGhhcHBlbmVkCgpUaGUgcHlwZXJmNjAwIHRlc3QgZmFpbHMgdG8gdmVyaWZ5IHdoZW4g
Y29tcGlsZWQgYnkgcmVjZW50IGNsYW5nIHJldmlzaW9ucy4KVGhlIGxhc3Qga25vd24gZ29vZCBy
ZXZpc2lvbiBpcyBbMF0sIHRoZSBmaXJzdCBrbm93biBiYWQgcmV2aXNpb24gaXMgWzFdLgpSZXZp
c2lvbiBbMV0gY29tZXMgZnJvbSB0aGUgcHVsbCByZXF1ZXN0IFsyXS4KClZlcmlmaWVyIGVycm9y
IHdoZW4gdXNpbmcgcmV2aXNpb24gWzFdOgoKICAgIC4uLgogICAgOyBpZiAoZnJhbWUtPmNvX25h
bWUpIEAgcHlwZXJmLmg6MTE4CiAgICAyNTQ2MDogKDc5KSByMyA9ICoodTY0ICopKHIxMCAtMzIp
ICAgIDsgUjNfdz1zY2FsYXIoKSBSMTA9ZnAwIGZwLTMyPW1tbW1tbW1tCiAgICAyNTQ2MTogKDE1
KSBpZiByMyA9PSAweDAgZ290byBwYys3CiAgICBUaGUgc2VxdWVuY2Ugb2YgODE5MyBqdW1wcyBp
cyB0b28gY29tcGxleC4KICAgIHZlcmlmaWNhdGlvbiB0aW1lIDgyMjE3NCB1c2VjCiAgICBzdGFj
ayBkZXB0aCAzNjAKCkFsbCB0ZXN0aW5nIGJlbG93IHdhcyBkb25lIHVzaW5nIHJldmlzaW9ucyBb
MF0gYW5kIFsxXS4KCiMgcHlwZXJmNjAwIHN0cnVjdHVyZQoKVGhlIHJlbGV2YW50IHBhcnRzIG9m
IHRoZSB0ZXN0IGxvb2sgYXMgZm9sbG93czoKCiAgICBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJv
b2wgZ2V0X2ZyYW1lX2RhdGEoLi4uKQogICAgewogICAgICAgIC4uLgogICAgICAgIGlmICghZnJh
bWUtPmZfY29kZSkKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgIC4uLgogICAgICAg
IGlmIChmcmFtZS0+Y29fZmlsZW5hbWUpIHsgLi4uIH0KICAgICAgICBpZiAoZnJhbWUtPmNvX25h
bWUpIHsgLi4uIH0KICAgICAgICByZXR1cm4gdHJ1ZTsKICAgIH0KCiAgICBpbnQgX19vbl9ldmVu
dCguLi4pCiAgICB7CiAgICAgICAgLi4uCiAgICAgICAgI3ByYWdtYSBjbGFuZyBsb29wIHVucm9s
bChVTlJPTExfQ09VTlQpICAgICAgLy8gIFVOUk9MTF9DT1VOVCA9PSAxNTAKICAgICAgICBmb3Ig
KGludCBpID0gMDsgaSA8IFNUQUNLX01BWF9MRU47ICsraSkgICAgICAvLyBTVEFDS19NQVhfTEVO
ID09IDYwMAogICAgICAgICAgICBpZiAoZnJhbWVfcHRyICYmIGdldF9mcmFtZV9kYXRhKC4uLikp
IHsKICAgICAgICAgICAgICAgIGlmICghc3ltYm9sX2lkKSB7IC4uLiB9CiAgICAgICAgICAgICAg
ICBpZiAoKnN5bWJvbF9pZCA9PSBuZXdfc3ltYm9sX2lkKSB7IC4uLiB9CiAgICAgICAgICAgICAg
ICAuLi4KICAgICAgICAgICAgfQogICAgICAgIC4uLgogICAgfQoKICAgIFNFQygicmF3X3RyYWNl
cG9pbnQva2ZyZWVfc2tiIikKICAgIGludCBvbl9ldmVudChzdHJ1Y3QgYnBmX3Jhd190cmFjZXBv
aW50X2FyZ3MqIGN0eCkKICAgIHsKICAgICAgICAuLi4KICAgICAgICBfX29uX2V2ZW50KC4uLik7
CiAgICAgICAgX19vbl9ldmVudCguLi4pOwogICAgICAgIF9fb25fZXZlbnQoLi4uKTsKICAgICAg
ICBfX29uX2V2ZW50KC4uLik7CiAgICAgICAgX19vbl9ldmVudCguLi4pOwogICAgICAgIC4uLgog
ICAgfQoKVGhlIGNhbGwgdG8gZ2V0X2ZyYW1lX2RhdGEoKSBpcyBpbmxpbmVkLgpUaGUgbWFpbiB0
YWtlYXdheXMgYXJlOgotIEJQRiBwcm9ncmFtIGNvbnNpc3RzIG9mIGZpdmUgY2FsbHMgdG8gX19v
bl9ldmVudCgpOwotIF9fb25fZXZlbnQoKSBoYXMgYSBiaWcgbG9vcCBpbnNpZGU7Ci0gbG9vcCBi
b2R5IGhhcyA1IGNvbmRpdGlvbmFscwogICh3aGVuIGNvdW50ZWQgd2l0aCBjb25kaXRpb25hbHMg
aW4gZ2V0X2ZyYW1lX2RhdGEoKSkuCgojIExMVk0gY2hhbmdlIGRlc2NyaXB0aW9uCgpUaGUgcmVs
ZXZhbnQgcGFydCBvZiBbMV0gaXM6CgogICAgLS0tIGEvbGx2bS9saWIvVHJhbnNmb3Jtcy9TY2Fs
YXIvTG9vcFVucm9sbFBhc3MuY3BwCiAgICArKysgYi9sbHZtL2xpYi9UcmFuc2Zvcm1zL1NjYWxh
ci9Mb29wVW5yb2xsUGFzcy5jcHAKICAgIEBAIC0xMjgyLDcgKzEyOTUsNyBAQCB0cnlUb1Vucm9s
bExvb3AoTG9vcCAqTCwgRG9taW5hdG9yVHJlZSAmRFQsIExvb3BJbmZvICpMSSwgU2NhbGFyRXZv
bHV0aW9uICZTRSwKICAgICAgIH0KCiAgICAgICAvLyBEbyBub3QgYXR0ZW1wdCBwYXJ0aWFsL3J1
bnRpbWUgdW5yb2xsaW5nIGluIEZ1bGxMb29wVW5yb2xsaW5nCiAgICAtICBpZiAoT25seUZ1bGxV
bnJvbGwgJiYgIShVUC5Db3VudCA+PSBNYXhUcmlwQ291bnQpKSB7CiAgICArICBpZiAoT25seUZ1
bGxVbnJvbGwgJiYgKFVQLkNvdW50IDwgVHJpcENvdW50IHx8IFVQLkNvdW50IDwgTWF4VHJpcENv
dW50KSkgewogICAgICAgICBMTFZNX0RFQlVHKAogICAgICAgICAgICAgZGJncygpIDw8ICJOb3Qg
YXR0ZW1wdGluZyBwYXJ0aWFsL3J1bnRpbWUgdW5yb2xsIGluIEZ1bGxMb29wVW5yb2xsLlxuIik7
CiAgICAgICAgIHJldHVybiBMb29wVW5yb2xsUmVzdWx0OjpVbm1vZGlmaWVkOwoKLSBgVVAuQ291
bnRgIGlzIGEgcHJlZmVycmVkIG51bWJlciBvZiBpdGVyYXRpb25zIHRvIGJlIHVucm9sbGVkLAog
IGl0IGlzIDE1MCBmb3IgcHlwZXJmNjAwOwotIGBUcmlwQ291bnRgIGlzIGEgcHJlZGljdGVkIG51
bWJlciBvciBsb29wIGl0ZXJhdGlvbnMsCiAgaXQgaXMgNjAwIGZvciBweXBlcmY2MDAuCgpUaGUg
aHVuayBhYm92ZSBkb2VzIGV4YWN0bHkgd2hhdCBjb21tZW50cyBzYXlzOgpwcmV2ZW50cyBwYXJ0
aWFsIHVucm9sbGluZyBvZiB0aGUgbWFpbiBweXBlcmY2MDAgbG9vcCBvbiBmdWxsCnVucm9sbGlu
ZyBwYXNzLgoKVGhlcmUgaXMgYWxzbyBhIHBhcnRpYWwgdW5yb2xsaW5nIHBhc3MgZG9uZSBsYXRl
ciBpbiB0aGUgcGlwZWxpbmUuCgojIExMVk0gY2hhbmdlIGltcGFjdCBvbiBweXBlcmY2MDAKClBy
aW9yIHRvIFsxXSB0aGUgbG9vcCBpbiBweXBlcmY2MDAgd2FzIHVucm9sbGVkIGJ5IGZ1bGwgdW5y
b2xsaW5nIHBhc3MsCmFmdGVyIFsxXSBpdCBpcyB1bnJvbGxlZCBieSBwYXJ0aWFsIHVucm9sbGlu
ZyBwYXNzLgpTdWNoIGNoYW5nZSBjYXVzZXMgYSBzdWJ0bGUgcmVhcnJhbmdlbWVudCBvZiBiYXNp
YyBibG9ja3MgaW5zaWRlIHRoZQpsb29wIHdoaWNoIHR1cm5zIG91dCB0byBiZSBpbXBvcnRhbnQg
Zm9yIHRoZSB2ZXJpZmllci4KClRoZSByZWFycmFuZ2VtZW50IG9jY3VycyBpbnNpZGUgaW5saW5l
ZCBib2R5IG9mIGdldF9mcmFtZV9kYXRhKCk6CgogICAgc3RhdGljIF9fYWx3YXlzX2lubGluZSBi
b29sIGdldF9mcmFtZV9kYXRhKC4uLikKICAgIHsKICAgICAgICAuLi4KICAgICAgICBpZiAoIWZy
YW1lLT5mX2NvZGUpCiAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICAuLi4KICAgIH0K
ClRyYW5zbGF0aW9uIGJlZm9yZSBbMV06ICAgICAgICAgICAgICAgICBUcmFuc2xhdGlvbiBhZnRl
ciBbMV0KCjsgaWYgKCFmcmFtZS0+Zl9jb2RlKSAgICAgICAgICAgICAgICAgICA7IGlmICghZnJh
bWUtPmZfY29kZSkKICByMyA9ICoodTY0ICopKHIxMCAtIDB4MzApICAgICAgICAgICAgICAgcjMg
PSAqKHU2NCAqKShyMTAgLSAweDMwKQogIGlmIHIzICE9IDB4MCBnb3RvICsweDIgPExCQjBfMTk+
ICAgICAgICBpZiByMyA9PSAweDAgZ290byArMHg0YiA8TEJCMF8zOT4KCkJlZm9yZSBbMV0gdGhl
IGZhbGwtdGhyb3VnaCBwYXRoIGlzIHRvIGByZXR1cm4gZmFsc2VgLAphZnRlciBbMV0gdGhlIGZh
bGwtdGhyb3VnaCBwYXRoIGlzIHRvIHRoZSByZXN0IG9mIGdldF9mcmFtZV9kYXRhKCkgYm9keS4K
ClRoZSBgaWYgKCFmcmFtZS0+Zl9jb2RlKWAgaXMgdGhlIGZpcnN0IGNvbmRpdGlvbmFsIGluIHRo
ZSBsb29wIGJvZHkKYW5kIGl0IGd1YXJkcyBhbGwgb3RoZXIgY29uZGl0aW9uYWxzIGluIHRoZSBi
b2R5Cih3aGVuICFmcmFtZV9jb2RlID09IDEgdGhlIHJlc3Qgb2YgY29uZGl0aW9uYWxzIGlzIHNr
aXBwZWQpLgoKQmVmb3JlIFsxXSB0aGUgdmVyaWZpZXIgd291bGQgcHJvY2VzcyBweXBlcmY2MDAg
aW4gdGhlIGZvbGxvd2luZyBvcmRlcjoKCi0gX19vbl9ldmVudCgpCiAgLSBwcm9jZXNzIGxvb3Ag
NjAwIHRpbWVzOgogICAgLSBgaWYgKCFmcmFtZS0+Zl9jb2RlKSByZXR1cm4gZmFsc2VgOgogICAg
ICAtIGZhbGwtdGhyb3VnaCBpcyB0byBgcmV0dXJuIGZhbHNlYDsKICAgICAgLSBwdXNoIG9uZSBq
dW1wIHRvIGp1bXAgaGlzdG9yeQogICAgICAtIGFzc3VtZSBmYWxsLXRocm91Z2ggYnJhbmNoIGFu
ZCBza2lwIHRoZSByZXN0IG9mIHRoZSBsb29wIGJvZHk7Ci0gX19vbl9ldmVudCgpOiBzYW1lIHRo
aW5nLCBwdXNoIDYwMCBqdW1wcyB0byBqdW1wIGhpc3Rvcnk7Ci0gX19vbl9ldmVudCgpOiBzYW1l
IHRoaW5nLCBwdXNoIDYwMCBqdW1wcyB0byBqdW1wIGhpc3Rvcnk7Ci0gX19vbl9ldmVudCgpOiBz
YW1lIHRoaW5nLCBwdXNoIDYwMCBqdW1wcyB0byBqdW1wIGhpc3Rvcnk7Ci0gX19vbl9ldmVudCgp
OgogIHRoaXMgaXMgdGhlIGxhc3QgY2FsbCB0byBfX29uX2V2ZW50LAogIGFsbCBicmFuY2hlcyB3
aXRoaW4gaXQgYXJlIHZlcmlmaWVkIGJlZm9yZSBwcm9jZWVkaW5nCiAgd2l0aCBicmFuY2hlcyBw
dXNoZWQgZm9yIHByZXZpb3VzIGNhbGxzLgoKV2hlbiB0aGUgbG9vcCBpbnNpZGUgdGhlIGxhc3Qg
Y2FsbCB0byBfX29uX2V2ZW50KCkgaXMgdmVyaWZpZWQgYQpjaGVja3BvaW50IGF0IGl0J3Mgc3Rh
cnQgYmVjb21lcyB2aWFibGUuCkJyYW5jaGVzIHB1c2hlZCB3aGVuIHByZXZpb3VzIGNhbGxzIHRv
IF9fb25fZXZlbnQoKSB3ZXJlIHByb2Nlc3NlZAp3b3VsZCBldmVudHVhbGx5IGhpdCB0aGlzIGNo
ZWNrcG9pbnQgYW5kIHRoZSB3aG9sZSBwcm9jZXNzIHdvdWxkCmNvbnZlcmdlIGV2ZW50dWFsbHku
ClRodXMsIGF0IGl0J3MgcGVhayB0aGUganVtcCBoaXN0b3J5IGxlbmd0aCB3b3VsZCBiZSB+NjAw
KjUgPT0gMzAwMC4KCkhvd2V2ZXIsIGFmdGVyIFsxXSB0aGUgZmFsbC10aHJvdWdoIHBhdGggZm9y
IHRoZSBgaWYgKCFmcmFtZS0+Zl9jb2RlKWAKbGVhZHMgdG8gb3RoZXIgY29uZGl0aW9uYWxzIGlu
IHRoZSBsb29wIGJvZHksCnB1c2hpbmcgdXAgdG8gNSBjb25kaXRpb25hbHMgdG8ganVtcCBoaXN0
b3J5IGZvciBlYWNoIGl0ZXJhdGlvbi4KSGVuY2UsIHBlYWsganVtcCBoaXN0b3J5IGxlbmd0aCB3
b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB+NjAwKjUqNSA9PSAxNTAwMC4KV2hpY2ggaXMgb3V0c2lk
ZSBvZiBjdXJyZW50IGxpbWl0cyBmb3IgdGhlIHZlcmlmaWVyLgoKIyBQb3NzaWJsZSBmaXggIzE6
IGNoYW5nZSBweXBlcmY2MDAgYmFzaWMgYmxvY2tzIGxheW91dAoKVGhlIGRpZmYgYmVsb3cgaXMg
c3VmZmljaWVudCB0byBtYWtlIHRlc3QgdmVyaWZ5IGFnYWluIGFmdGVyIFsxXQood2hlbiB0ZXN0
ZWQgZm9yIGNwdXY0LCBjcHV2MyBnZW5lcmF0ZXMganVtcHMgb3ZlcmZsb3dpbmcgMTYtYml0IG9m
ZnNldCk6CgogICAgLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3B5cGVy
Zi5oCiAgICArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvcHlwZXJmLmgK
ICAgIEBAIC05Nyw4ICs5NywxMCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgZ2V0X2Zy
YW1lX2RhdGEodm9pZCAqZnJhbWVfcHRyLCBQaWREYXRhICpwaWREYXRhLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZyYW1lX3B0ciArIHBpZERhdGEtPm9mZnNldHMuUHlGcmFtZU9i
amVjdF9jb2RlKTsKCiAgICAgICAgICAgIC8vIHJlYWQgZGF0YSBmcm9tIFB5Q29kZU9iamVjdAog
ICAgLSAgICAgICBpZiAoIWZyYW1lLT5mX2NvZGUpCiAgICAtICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOwogICAgKyAgICAgICBhc20gdm9sYXRpbGUgZ290bygiaWYgJVtmX2NvZGVdICE9IDAg
Z290byAlbFtoYXNfZl9jb2RlXSIKICAgICsgICAgICAgICAgICAgICAgICAgICAgICAgOjogW2Zf
Y29kZV0iciIoZnJhbWUtPmZfY29kZSkgOjogaGFzX2ZfY29kZSk7CiAgICArICAgICAgIHJldHVy
biBmYWxzZTsKICAgICtoYXNfZl9jb2RlOgogICAgICAgICAgICBicGZfcHJvYmVfcmVhZF91c2Vy
KCZmcmFtZS0+Y29fZmlsZW5hbWUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6
ZW9mKGZyYW1lLT5jb19maWxlbmFtZSksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZnJhbWUtPmZfY29kZSArIHBpZERhdGEtPm9mZnNldHMuUHlDb2RlT2JqZWN0X2ZpbGVuYW1lKTsK
CkVmZmVjdGl2ZWx5IHRoaXMgZm9yY2VzIHZlcmlmaWVyIHRvIGZpcnN0IGV4cGxvcmUgYHJldHVy
biBmYWxzZWAKYnJhbmNoIG9mIHRoZSBmaXJzdCBjb25kaXRpb25hbCBpbiB0aGUgbG9vcCBib2R5
LApzYW1lIHdheSBpdCB3YXMgZG9uZSBiZWZvcmUgWzFdLgoKKFRoZSBsaWtlbHkvdW5saWtlbHkg
bWFjcm8gcmVseWluZyBvbiBfX2J1aWx0aW5fZXhwZWN0KCkgZG9uJ3QgZ2l2ZQogdGhlIGRlc2ly
ZWQgY29kZSBsYXlvdXQgZm9yIHNvbWUgcmVhc29uKS4KCiMgUG9zc2libGUgZml4ICMyOiBjaGFu
Z2UgcHlwZXJmNjAwIGxpbWl0cwoKVGhlIGRpZmYgYmVsb3cgcmVkdWNlcyB0aGUgbG9vcCBzaXpl
IHN1ZmZpY2llbnRseSB0byBmaXQgaW5zaWRlIGp1bXAKaGlzdG9yeSAoYWdhaW4sIHdvcmtzIGZv
ciBjcHV2NCwgYnV0IG5vdCBmb3IgY3B1djMpOgoKICAgIC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9ncy9weXBlcmY2MDAuYwogICAgKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL3Byb2dzL3B5cGVyZjYwMC5jCiAgICBAQCAtMSw2ICsxLDYgQEAKICAgICAvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAogICAgIC8vIENvcHlyaWdodCAoYykgMjAx
OSBGYWNlYm9vawogICAgLSNkZWZpbmUgU1RBQ0tfTUFYX0xFTiA2MDAKICAgICsjZGVmaW5lIFNU
QUNLX01BWF9MRU4gMjMwCiAgICAgLyogRnVsbCB1bnJvbGwgb2YgNjAwIGl0ZXJhdGlvbnMgd2ls
bCBoYXZlIHRvdGFsCiAgICAgICogcHJvZ3JhbSBzaXplIGNsb3NlIHRvIDI5OGsgaW5zbnMgYW5k
IHRoaXMgbWF5CiAgICAgICogY2F1c2UgQlBGX0pNUCBpbnNuIG91dCBvZiAxNi1iaXQgaW50ZWdl
ciByYW5nZS4KCiMgUG9zc2libGUgZml4ICMzOiB2ZXJpZmllciBjaGFuZ2VzCgpBbm90aGVyIG9w
dGlvbiB3b3VsZCBiZSB0byBmb3JnbyBjdXJyZW50IHZlcmlmaWVyIGNvbmRpdGlvbmFsCmV4cGxv
cmF0aW9uIHJ1bGVzOgp3aGVuIGluc2lkZSBhIGxvb3AsIGRvbid0IGV4cGxvcmUgdGhlIGZhbGwt
dGhyb3VnaCBicmFuY2ggZmlyc3QsCmluc3RlYWQgcHJlZGljdCB3aGljaCBicmFuY2ggd291bGQg
cHVzaCBsZXNzIGNvbmRpdGlvbmFscwpvbnRvIGp1bXAgaGlzdG9yeSBhbmQgZXhwbG9yZSB0aGF0
IGZpcnN0LgoKTmVlZCBtb3JlIHRpbWUgdG8gYXNzZXMgaWYgdGhpcyBhIGZlYXNpYmxlIG9wdGlv
biBpbiB0ZXJtcyBvZiBhZGRlZCBjb21wbGV4aXR5LgoKIyBMaW5rcwoKWzBdIExhc3QgZ29vZCBy
ZXZpc2lvbjoKICAgIGMzMjkxMjUzYzNiNSAoIlJldmVydCAiW3NjdWRvXSBbTVRFXSByZXNpemUg
c3RhY2sgZGVwb3QgZm9yIGFsbG9jYXRpb24gcmluZyBidWZmZXIiICgjODA3NzcpIikKWzFdIEZp
cnN0IGJyb2tlbiByZXZpc2lvbjoKICAgIDk5ZGRkNzdlZDllMSAoIltMb29wVW5yb2xsXSBJbnRy
b2R1Y2UgUHJhZ21hVW5yb2xsRnVsbE1heEl0ZXJhdGlvbnMgYXMgYSBoYXJkIGNhcCBvbiBob3cg
bWFueSBpdGVyYXRpb25zIHdlIHRyeSB0byB1bnJvbGwgKCM3ODY0OCkiKQpbMl0gaHR0cHM6Ly9n
aXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L3B1bGwvNzg2NDgK


--=-eURiOfxFdEHNhEJV5wZ3--
