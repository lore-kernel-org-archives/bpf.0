Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEA45199D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502874; cv=none; b=AW+2d4E0R3J403bHjuEMorN5NiAmhckA7s+A/eLpPZAF+ZqzCfB2im6p/ZTX5lh77ujc5OeSxfFoRsd0hcTpYuRviE2wJxxDGp+5ZhOiaZqCcyWFBCOa9LffZl+ha5oCbxyE5Psd8gyzJf3tcx57GGpnJMtm2LaGFDyIsTYoTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502874; c=relaxed/simple;
	bh=SUDSiZUX9Sg5L82baFjRkhLC6/5lJwf6fgzUEgg/41k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=Ge4lv0s79/ZPACs34KAzOAzhM0zQlI6hx4TG7KnA6nwFBPIBtKoyyFaaFwA/F8ntTnZd9GlXCIRf0YWRutlmcFeppEwaIird6WEtdDfzFfVQm1/rOO/oYDC0Rd/0GuFhnwfrnu/jCI+AYDEKMZslHqvlle7VwCGZVnKapT9BSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jddz+4xq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jddz+4xq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B6CE1A07F0;
	Tue, 15 Sep 2026 20:07:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3ECB2602B0;
	Tue, 15 Sep 2026 20:07:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A3AA11C7B00F;
	Tue, 15 Sep 2026 22:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789502862; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IF/NxfzuJVfbyMAx4PSxp6TfoekaxgwaVfmnRAyW3hs=;
	b=Jddz+4xqPSlx200zmhQNTfvoQvVCjgqeTLgKD4nTn0S0k7UGzvqYneHuToXx1lv2l8ZouK
	FmHY51YzT+jZ8zE0uJqTYE66aLS8INwXW7j0xnWdgDc460vd2NZX6U2u6cOL5VdYKUgFK5
	+J2eGoswfkQcW+fv4bLVfqTykhrgJB4LQjSwI/09dUEh7TgK23zCr/AiY3aHlo2/x26VHR
	epcBsMdIvAv82iQr3eWMYrx7oFVIiK5/qUPJQZYz+Ju/sdoHQPUPe14W+pZ5pbkV/eDqKW
	KvfdRKlV3qPVLzlsw/6YhP5ji5gqBwhzBwlWkFHD0Kiba3R4FYvLQTF7x13fQA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 22:07:34 +0200
Message-Id: <DLG5TIIHIMC2.2YCCY0UX86YQF@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Madhav Khosla" <madhav.khoslaa@gmail.com>, <bot+bpf-ci@kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Fix csum_partial() dropping trailing
 byte on odd length
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <bpf@vger.kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <sdf@fomichev.me>, <alexis.lothore@bootlin.com>, <martin.lau@kernel.org>,
 <mason@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260915145054.164857-1-madhav.khoslaa@gmail.com>
 <58262a1911ba8265b8745e4a2f9e592ddfa74c814b4359a83fcf449ea32904fd@mail.kernel.org> <CAHFb0oBSaP90J=oF85grEBGB8VmE=_89W5_xBznpSP=nQzQK_w@mail.gmail.com>
In-Reply-To: <CAHFb0oBSaP90J=oF85grEBGB8VmE=_89W5_xBznpSP=nQzQK_w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Madhav,
thanks for the fix.

On Tue Sep 15, 2026 at 6:43 PM CEST, Madhav Khosla wrote:
> Note: Resending as plain text

[...]

Could you please keep your answers interleaved in the previous messages
next time ?

> 1. checkpatch --strict doesn't flag it, and it's not actually an
>    outlier in the tree; bpftool_helpers.c, cap_helpers.c, disasm.c,
>    btf_helpers.c, netlink_helpers.c, jit_disasm_helpers.c,
>    trace_helpers.c, uprobe_multi.c and bench.c all do the same thing.
>    I'll leave it as is.

Checkpatch will (unfortunately) not raise any warning for this. And yes,
there are discrepancies in the tree, but adding more will just increase
the noise on each review. The check is voluntarily enforced in the
review prompts, so new comments should comply with it:

https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/bpf.md=
#bpf-comment-style

> 2. A second pointer would result in the same code either way, the cast ju=
st
>    moves from inside the loop to the declaration. I see no reason to
>    carry two pointers into the same buffer for that.
>    And for __builtin_memcpy(), it's because this header doesn't pull
>    in <string.h>, and I didn't want to add that just for a 1-byte copy.
>    It's also what a bunch of the progs/ files already do, so it's not
> exactly out of place here either.

[...]

IMHO the provided Fixes tag does not make sense here because commit
f4504af68575 ("selftests/bpf: move ip checksum helper to network
helpers") just moved the helper without changing the computation, it
was already dividing len by two. The Fixes tag should either target
the actual commit introducing ip_csum in xdp_metadata.c (I guess it
would be commit e2a46d54d7a1 ("selftests/bpf: Verify xdp_metadata
xdp->af_xdp path") then), or just be dropped completely (I feel like
the latter is the proper option, but I'll let maintainers conclude)

Ensuring that selftests would fail without your fix would be nice
though, maybe by ensuring that at least one of csum_partial's user uses
an odd data size ? eg:

--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.=
c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.=
c
@@ -27,7 +27,7 @@
 #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
 #define MAX_SOURCE_PORTS 3
 #define TEST_PACKETS_COUNT 10
-#define TEST_PACKET_LEN 100
+#define TEST_PACKET_LEN 99
 #define TEST_PACKET_PATTERN 'a'
 #define TEST_IPV4 "192.168.0.1/32"
 #define TEST_IPV6 "100::a/128"

Thanks,

Alexis

>
> Madhav
>
>
> On Tue, Sep 15, 2026 at 9:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>>
>> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/tes=
ting/selftests/bpf/network_helpers.h
>> > index 75133119c04a3..f6d28a2de7888 100644
>> > --- a/tools/testing/selftests/bpf/network_helpers.h
>> > +++ b/tools/testing/selftests/bpf/network_helpers.h
>> > @@ -129,12 +129,22 @@ static __u16 csum_fold(__u32 csum)
>> >
>> >  static __wsum csum_partial(const void *buf, int len, __wsum sum)
>> >  {
>> > -     __u16 *p =3D (__u16 *)buf;
>> > +     const __u8 *p =3D buf;
>> >       int num_u16 =3D len >> 1;
>> >       int i;
>> >
>> >       for (i =3D 0; i < num_u16; i++)
>> > -             sum +=3D p[i];
>> > +             sum +=3D ((const __u16 *)p)[i];
>> > +
>> > +     /* RFC 1071: an odd-length buffer's trailing byte is paired with
>> > +      * a zero pad byte to form the final 16-bit word.
>> > +      */
>>
>> A subsystem pattern flags this as potentially concerning: the BPF
>> comment-style guide states that multi-line comments under
>> tools/testing/selftests/bpf/ must have the opening '/*' on its own line,
>> with the comment text starting on the next line:
>>
>>         /*
>>          * RFC 1071: an odd-length buffer's trailing byte is paired with
>>          * a zero pad byte to form the final 16-bit word.
>>          */
>>
>> The comment text itself is accurate and matches RFC 1071. Is the current
>> style acceptable given that the surrounding file has no other inline
>> multi-line comments in this format?
>>
>> > +     if (len & 1) {
>> > +             __u16 tail =3D 0;
>> > +
>> > +             __builtin_memcpy(&tail, p + len - 1, 1);
>> > +             sum +=3D tail;
>> > +     }
>> >
>> >       return sum;
>> >  }
>>
>> This isn't a bug, but would keeping a separate '__u16 *' pointer
>> alongside the byte pointer let the loop body stay as it was, rather than
>> casting inside the subscript? Also, is there a reason for using
>> '__builtin_memcpy()' here instead of plain 'memcpy()' like the rest of
>> the selftests tree?
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a=
 bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READ=
ME.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34986=
038731




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

