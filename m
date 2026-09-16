Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF94A1E12
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557824; cv=pass; b=tbqY/uLUP5vOFx8KXI6H2xzrK46O/ONQmg96dgnqmm9QmMAMJcOp6wL1b0dDUkUpqhx47BbKL8efZk6oAKbe7ktnxeohwyW9fZ35TCfz30mJbH+Iqr+EZLp3qfj1iUY3V6bQkcQpBO3VtbSuDJeyyGSq9TafShGoafQlMZ5rMI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557824; c=relaxed/simple;
	bh=jM899aUcGSNkZt1z0NkUVi8iHU08UOxedg9xB3HuUJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDa9GLFiWQ0DuLQLP8mZP56Ud+XASqVXXRtNRSvRLStRjwlZYlGXzW5LVqO8iCnlBakT15in259ahOH4JFOgsK+hE4/m1AXAdcPRyLVGODHn0MvGQmJmY26rAsC+zS5CvaUa/8YKP8y3a5PfhHQm/ExMo9aJLshQEO/n/Rm+i/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0YTyoP2; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0YTyoP2"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae7089c1so420939eaf.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 04:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789557809; cv=none;
        d=google.com; s=arc-20260327;
        b=RZsbUB3/9iPgFWq7Eindb7EnZw3CZB4iA2WBFv82FnoTx1WxHKKkWcHX6Xl6EOY6oL
         arbpw9eK0k1g9ejmoiafMHPhANCPrayrhKzDZN3R1QGaNl467/qh6xrfjqrZQlUB7jO1
         B7ZhKIWRbWSa5eACQ47GTaT/BdHLo3kRQj9KpDhiTqY2NuAnAQB9SCFAUofyExDJmKmC
         SUN7QEZSg5eIMeQUz61cDaRNIDZc9V3lCqbuVOK9eKWPgnms7exNm/gkUzRqSIi0kWoF
         vJ7TWoVze2JyKRWgPoNYV3/VJ1ZRrVuDlwmJsAZLZwdlyPC4BBzIL7raYYSc4q56Z213
         CMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pq0abxMgoS3MLnB/CzCGX8+JCQ4kp3NYXwMl9cMPeZE=;
        fh=PGJMibUg5vHtBm8HGbn+tEwgzT5K025+D4NZ+z8SsbQ=;
        b=lxAlYmpaP0bA3SM3NwBsfKdE6Fc2ON1qQD8X8ac+Avp+aBOrVTXpsHpPBXZbZTf1XC
         4d5TbaT7G/KeX22SknutKYRXVvR/yXerrH/0ti1vTpLvJnAboP82r+XPEecvDNmeGgnX
         GG564BRbeTV9KZLG6TpqXUmrm9B8qSwGrowzRkWw3FbGCTjEUQZqdqHoemXGyOKTZjfL
         PfqzVSeX5JYdzgOUannEiFJwFi+6lUFHl1nzGkYVK6acdWXIN8DofHjefvYOnWjewFWA
         oa5WE63OODphRIu1FxLZdL+NAjd312cYYFb+RS5ij45sKFPBSSyXGZGVDrUwWVTNYRcu
         gvBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789557809; x=1790162609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pq0abxMgoS3MLnB/CzCGX8+JCQ4kp3NYXwMl9cMPeZE=;
        b=Y0YTyoP273lwtVn30de16nliOLhIT90m+KGdcLkDhlB1JGIJfGiYN1Vny2sNk81Xy0
         yD8YBPycxfB0T8gnzac/sfJswlf0h1uTUW/cur6eGAuhc3s1iL8/AaFozjcmnqEE4LjR
         DIlYAB8Zr05Wa4rDTXioU32dF3yU3XB0ea4sXsyozX1+JIG/+Q7LT7U2kH8z61TURW76
         oIPhXbg3lXIe0IbLTnPXM2ubHkd90uqlQPZxXETww277cqnW8ajJPEQX4hL5F4BFnMZl
         LgqtUkvUBzQ2W+xBkP7znSGvc+clkSa0+iJHkjqJ2RmIaMkGovQvMMPdTvemsgJpREOD
         pvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557809; x=1790162609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pq0abxMgoS3MLnB/CzCGX8+JCQ4kp3NYXwMl9cMPeZE=;
        b=w3sF7a/OpuW7eNu0uuwCIRUhrZuVX5Iq2Z9MfuwARvQbXxSR9S3sY8enjQvwWiUVUl
         lWecGafPbqmdjpB3yf/lqBiSOIbzUh805pFLcjk09/KWRJzoPwNphOpc0IQU7c3bL76A
         O0Rx2LqrbbDRN1ks2lvcjdgt4c4wjTy5tSFLk8CDvOL27rMUKqFklHFhRiH6FIqmLq4r
         cnaz8caetdX+TcQrXkZrDks3+J4eFHhZ57BbITdDggOT76Yx1ncrZy1r9EFFRLyTspkt
         voZ/si6a15sRTx1Ljk5YAnUUKef2FEkgqWcDe5D4ci7DZci33rRbJw2zbRDdKZS0qFpH
         36mw==
X-Forwarded-Encrypted: i=1; AKwUvBzMJ97MkbqRVhnq5Vl3bk0OPK0bv8G7LueBmSatmEnGE1iuJikqB9ez0yjhD9T3fgtFb8I=@vger.kernel.org
X-Gm-Message-State: AFuF++nEDOZp9vyvWiVZ7QpxGkrrj97X3ddhe0MTg0UBs9lumWXjc+pc
	D9LB7U0nVYeAP1iE3Kr2tBeh9KCUrmdfkv4l7PEM9h3HwC4LBoaB4FSB+V3GRqBrHq/xj9EFixJ
	hdmC+GfjJCw/Cy+AmU5bgcho5P59oiiQ=
X-Gm-Gg: AYBFou07ohibRVmR5N1DGm4cLHTCK2SlC1XfCCNNC6pJr2Bx43ofhtBhmiLi9yaaIlN
	tnXPpMQv78zIBYAWMR0S+gkUDXPTTM3XJ4gXfizGWYylayyI+5X+CxoqLOpuAe4tOalIrY+2wmd
	7ctd/rsU/wIlYhHcmoZBBVV3fvS0MUoiS8BfvXt+/GQQ39a6PFqfgJ5z5LlH7MLyNFmfJfMAkRb
	wSlafRp0Ei6ySY5Ty1lLDJ0Bw3UaGwpg4PKZ+Rh79CEiULSx9JGzxGk0dyRmWPsjfc2t7X7DFWx
	nwpVkXiI5/WuBaEjAmT1CCjHPAum5KBANMr+ZH3one1+ziwo75sHJqtYwNtCWlgGRr7SvWNDQ01
	FpZN2W4ZxaXpSexFeWlWiNvBf1T8GocvWDhP7CMbLKvK4SwBi71kdMUQDDoo9qgR3fUMB/4hLPb
	cJHPBM6Elc5QO/LxnxUVbmdq+Xi1miSca4
X-Received: by 2002:a05:6820:f025:b0:6b7:8396:f3c6 with SMTP id
 006d021491bc7-6c7d36fd32cmr2015956eaf.40.1789557808542; Wed, 16 Sep 2026
 04:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915145054.164857-1-madhav.khoslaa@gmail.com>
 <58262a1911ba8265b8745e4a2f9e592ddfa74c814b4359a83fcf449ea32904fd@mail.kernel.org>
 <CAHFb0oBSaP90J=oF85grEBGB8VmE=_89W5_xBznpSP=nQzQK_w@mail.gmail.com> <DLG5TIIHIMC2.2YCCY0UX86YQF@bootlin.com>
In-Reply-To: <DLG5TIIHIMC2.2YCCY0UX86YQF@bootlin.com>
From: Madhav Khosla <madhav.khoslaa@gmail.com>
Date: Wed, 16 Sep 2026 11:23:16 +0000
X-Gm-Features: AcwNN1Uurq1m35WBeUHFqoDzmFJrHo-TJ-EHdrJQHgHhPhrSGSXemB7vZgyBLuY
Message-ID: <CAHFb0oDkKQxdxhCyx-+Mk2baMXMAQo0GvoNjBTL_UXOVqy2tiQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix csum_partial() dropping trailing
 byte on odd length
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	sdf@fomichev.me, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexis,

On Tue, 15 Sep 2026 20:07:00 UTC, Alexis Lothor=C3=A9 wrote:
> Could you please keep your answers interleaved in the previous messages
> next time ?

Sure, I'm doing that here.

> Checkpatch will (unfortunately) not raise any warning for this. And yes,
> there are discrepancies in the tree, but adding more will just increase
> the noise on each review. [...] new comments should comply with it

Valid; fixed in the V2 patch.

> IMHO the provided Fixes tag does not make sense here because commit
> f4504af68575 [...] just moved the helper without changing the
> computation [...] The Fixes tag should either target the actual commit
> introducing ip_csum in xdp_metadata.c [...] or just be dropped
> completely

Retargeted it. f4504af68575 moved the helper but sizeof(iphdr) is
always a multiple of 32 bit words / 4 Bytes (iph->ihl counts in 4-byte
words), so the odd-length path was never reachable through
build_ip_csum().

> Ensuring that selftests would fail without your fix would be nice
> though, maybe by ensuring that at least one of csum_partial's user uses
> an odd data size ?

I tested on the edge case without my fix, and it failed under
vmtest.sh:

    test_flow_dissector_classification:FAIL:test third port unexpected
    test third port: actual 0 !=3D expected 10
    #137/6   flow_dissector_classification/ipv6:FAIL
    #137     flow_dissector_classification:FAIL
    Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED

kernel drops the packet over the bad checksum. I added the edge case
to be tested in the code, like this:

  #define TEST_PACKET_LEN 99

With the fix applied, both flow_dissector_classification and
xdp_metadata pass in full.

v2 sent separately.

Madhav

On Tue, Sep 15, 2026 at 8:07=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Madhav,
> thanks for the fix.
>
> On Tue Sep 15, 2026 at 6:43 PM CEST, Madhav Khosla wrote:
> > Note: Resending as plain text
>
> [...]
>
> Could you please keep your answers interleaved in the previous messages
> next time ?
>
> > 1. checkpatch --strict doesn't flag it, and it's not actually an
> >    outlier in the tree; bpftool_helpers.c, cap_helpers.c, disasm.c,
> >    btf_helpers.c, netlink_helpers.c, jit_disasm_helpers.c,
> >    trace_helpers.c, uprobe_multi.c and bench.c all do the same thing.
> >    I'll leave it as is.
>
> Checkpatch will (unfortunately) not raise any warning for this. And yes,
> there are discrepancies in the tree, but adding more will just increase
> the noise on each review. The check is voluntarily enforced in the
> review prompts, so new comments should comply with it:
>
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/bpf.=
md#bpf-comment-style
>
> > 2. A second pointer would result in the same code either way, the cast =
just
> >    moves from inside the loop to the declaration. I see no reason to
> >    carry two pointers into the same buffer for that.
> >    And for __builtin_memcpy(), it's because this header doesn't pull
> >    in <string.h>, and I didn't want to add that just for a 1-byte copy.
> >    It's also what a bunch of the progs/ files already do, so it's not
> > exactly out of place here either.
>
> [...]
>
> IMHO the provided Fixes tag does not make sense here because commit
> f4504af68575 ("selftests/bpf: move ip checksum helper to network
> helpers") just moved the helper without changing the computation, it
> was already dividing len by two. The Fixes tag should either target
> the actual commit introducing ip_csum in xdp_metadata.c (I guess it
> would be commit e2a46d54d7a1 ("selftests/bpf: Verify xdp_metadata
> xdp->af_xdp path") then), or just be dropped completely (I feel like
> the latter is the proper option, but I'll let maintainers conclude)
>
> Ensuring that selftests would fail without your fix would be nice
> though, maybe by ensuring that at least one of csum_partial's user uses
> an odd data size ? eg:
>
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificatio=
n.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificatio=
n.c
> @@ -27,7 +27,7 @@
>  #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
>  #define MAX_SOURCE_PORTS 3
>  #define TEST_PACKETS_COUNT 10
> -#define TEST_PACKET_LEN 100
> +#define TEST_PACKET_LEN 99
>  #define TEST_PACKET_PATTERN 'a'
>  #define TEST_IPV4 "192.168.0.1/32"
>  #define TEST_IPV6 "100::a/128"
>
> Thanks,
>
> Alexis
>
> >
> > Madhav
> >
> >
> > On Tue, Sep 15, 2026 at 9:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >>
> >> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/t=
esting/selftests/bpf/network_helpers.h
> >> > index 75133119c04a3..f6d28a2de7888 100644
> >> > --- a/tools/testing/selftests/bpf/network_helpers.h
> >> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> >> > @@ -129,12 +129,22 @@ static __u16 csum_fold(__u32 csum)
> >> >
> >> >  static __wsum csum_partial(const void *buf, int len, __wsum sum)
> >> >  {
> >> > -     __u16 *p =3D (__u16 *)buf;
> >> > +     const __u8 *p =3D buf;
> >> >       int num_u16 =3D len >> 1;
> >> >       int i;
> >> >
> >> >       for (i =3D 0; i < num_u16; i++)
> >> > -             sum +=3D p[i];
> >> > +             sum +=3D ((const __u16 *)p)[i];
> >> > +
> >> > +     /* RFC 1071: an odd-length buffer's trailing byte is paired wi=
th
> >> > +      * a zero pad byte to form the final 16-bit word.
> >> > +      */
> >>
> >> A subsystem pattern flags this as potentially concerning: the BPF
> >> comment-style guide states that multi-line comments under
> >> tools/testing/selftests/bpf/ must have the opening '/*' on its own lin=
e,
> >> with the comment text starting on the next line:
> >>
> >>         /*
> >>          * RFC 1071: an odd-length buffer's trailing byte is paired wi=
th
> >>          * a zero pad byte to form the final 16-bit word.
> >>          */
> >>
> >> The comment text itself is accurate and matches RFC 1071. Is the curre=
nt
> >> style acceptable given that the surrounding file has no other inline
> >> multi-line comments in this format?
> >>
> >> > +     if (len & 1) {
> >> > +             __u16 tail =3D 0;
> >> > +
> >> > +             __builtin_memcpy(&tail, p + len - 1, 1);
> >> > +             sum +=3D tail;
> >> > +     }
> >> >
> >> >       return sum;
> >> >  }
> >>
> >> This isn't a bug, but would keeping a separate '__u16 *' pointer
> >> alongside the byte pointer let the loop body stay as it was, rather th=
an
> >> casting inside the subscript? Also, is there a reason for using
> >> '__builtin_memcpy()' here instead of plain 'memcpy()' like the rest of
> >> the selftests tree?
> >>
> >>
> >> ---
> >> AI reviewed your patch. Please fix the bug or email reply why it's not=
 a bug.
> >> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/RE=
ADME.md
> >>
> >> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/349=
86038731
>
>
>
>
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
