Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793914619;
	b=15Uo8w2XSdCmSw1J/MyXGtDXPtePWJ2M8hEkGmOU2Kpse9hXJC1nRkInj5x28vVhO4B4
	 OD0BzsfPUszD6dUvM/4m2171CDqKb2mrWDwRqtrNOvxmCS14OQHR1ZxPCg46YqdDtTZn7
	 cbmnLUxUVOWQsJR/zfIQWHMYUpg0cAnYRKMcSVdfXzMnuhezeVZ3ExrGnKM5utEc7nmbn
	 HR8401MUnRKBA3NYocbwCOPcHze7xP9JJMEXKY+1inoWh/qb3cdATK72QQhsQZwjMGSR5
	 x0ej2Y3hzWX8WALLVaWv+MjYxHwBHJZbPv8vPOllBuv6Ojxnr5yyg6bVDH2JWS7xLHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
	b=Go64JcBOzkXsgyuKKZJBJAMGMP04MrUasCt+b3wML9asMAegIkk12M0A8HfaA//JxohL
	 7DKcRkrWydY6sC2hwtEGshgoPxlqZLY6BJOt8iYy0vrp0VI+o9/NLnm6j0f5CKSEzbD76
	 /Ihx2/QG09qoE4cfaD0W9y/gyH/mjEmGu8NOH3NhU8rYlGS5voraYvr+yP6EA+yvps9Jb
	 vEIRFxfi4KtqROePkBnhbkH5c6j/XiOrHhLS5Oxl1uVDnLJqTWvzhBCEwOgE6K1JjP3mz
	 +TVbK3/SLXm5BogeKz4N1LpeBWP2xLO557iSedg8MMBkQTWQrdUC3AehdaDf2I59oUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNV3YK2A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965F606A334
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C965F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNV3YK2A
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c247f6687dcso407239066b.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 13:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793914612; cv=none;
        d=google.com; s=arc-20260327;
        b=FlXof0RuLbzpo1esqXKe+qhc4rX53m+IXtVVwgVvsZmESWx4cGqzR4PdxTDqZE2jNI
         8C91VXS8WsT8+/S011D2dzOsv6jeJPUZYqATVVPnuzF3ylWsvVqzvOn/WL21+5HjVZlh
         TRfywClWLIWtSy5E9ZpXlXktc5hgQsWgei9uLVv+MySRKhH1PEB6VzwjF0day298FfGA
         MiMNzQ7jiNRIdNkyR1aTBPXjQER5UgwssO3ogl45XQX0QL7wHKAc/wkYJykD5bgKxGGs
         Mxu4wHUncKkkLVJfqS+RW9hkGBCSClTuEKLicne0znA5YKGQbnGGqgJuBOrWg5CGjI6w
         F1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        fh=ok07m3FvHb3eNbKFLPdjJjsl4wKF1W9f87O0n8XdzjI=;
        b=srfbTm7WFF71dCJWh9nOFnvRqHbHisP++lI904nkWzReUekd4Rez5qtiYa4xPIt1C+
         g7W3+D/8ml5DAwi/9Dbd13+gJTro5FWFmP4qIkXILfgPIRD07neL7bgzSIaNN/kE4ZfR
         tQDF54SDXNE3Y4ZdZ8DU1NqvDJdmBWKt7AJXzpP5EM7LHrrtncuJlYRATxgzanWRIO+Q
         kPao9p7YtPhr1MtP0IO82UdFDoQmmy0W/a5E6kK3EzbOaQKIvZltM04opcDHTmVdDKTm
         fuQCf1u6bH9kpGLERXKUNMfghqXcxSmF9g38dYk51TT1clChQmqPOrwjnX972yVw3K80
         JM+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793914612; x=1794519412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        b=qNV3YK2AvifU1tOsCQ8wk4axq2Bpnp9T4w05lcq35MoN1lflDph5Y1IYtTpLN9oiu1
         oljv6zhoDl0Vdx6KwOE+YZ2XrvF12KIBahqeuzL0AI1Ihf1xglBIFGRlNFmbLRw1BvGj
         cHOsnpHe5ExcVUNebf5XytYqgD/im+o9YfI2/bO5gRjiKXBfTL4w9S2eMuvmZ4trc6CA
         kCNJxMHTFWh4eiUO3KMPLUXRVAjTsqzWtt3brnLtM+MWPucllL2IlplxbMf3C29B/5Fm
         Zq9m93kWEpns5SBYbYB5Q3+CTVkb/fUXg2wz7C4TsaW16nXsgwuTB3NnvQNvu0l335c9
         ZYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914612; x=1794519412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        b=f5e25wmhRKFcsuV/dwO3SFLmaI0BCqMUtDhemuVg316GClGvTJdDULxWemTdxuM5hR
         yBUudp9zQ3IKtRTI0iB+h7QIYA7zWm+6XAoIlcYy4oHbvyuqyoAipSpEGqc1NOZpmD6Q
         NttGObj2FpkuhfY3Ew0oPTk5nwczC2Trc0fx4Pi4lZVItg7dcfx+oatD7DJM+B6W+FjL
         Qo5sw3cTqp5zcnfo3x6wB3axumSiu1l0Mi8ZsAd/fCBwaCuC8HAIg0arJ1DqIPhBEM7o
         yfNHisebOyQjoyrMOGgVhzbVg/rppNtow+T74VhILrn5QcI9EmqWwqr2UV+noB5dTn8R
         5d9w==
X-Forwarded-Encrypted: i=1; AKwUvBxTdg1XuJyJClS6ZBYLqWFqghsmj/mN7D+2YbfRZ2AgebxM65U7pGfHKVs4L4fmdqjA+Pk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZMR9OfTO9bgCHSfz/ed5uX8GDAQvcczVpX7jz1+ldUkDG64Q5
	+CAuyXkFa7y4oakntkyu2XeNMto78L1BqR5zSi9pGd5HHxS/c4eS97oKIe9n4urTsNxz4CWriU+
	8PbBJu8b+ASyCp4Z/cnPpC34QOV6vJTi/F0fRzLQ5
X-Gm-Gg: AYBFou1CwagmodnWtJeChnfRqoVC4kBRVWUqqIr7D/lNy5PuN7fs9HuxhD6PYeoFwHY
	FMD7H948KpK1Wo0lCyZ82VeOp0kvEEDJYzOCQuOKS3CLPdHZ0uxLVbovHnwxLqe2JAW5bG0Ft9c
	62f7mR+Vp6nQvRKY/D1YWHrQrcPUluXenEEm5EQI7UdTlKlSzv3Hbuc08jZE22bUXZutHVmHzbE
	8oWHwBt4RWiR9bqRyGvHZB8s/l508j91WrbXqz7LHBVPx0QLlibiyhXMt1n9Vpf67xCPzUX+MXL
	ZtDSj+OslDURK+/mbKKGkJljmZrejTiDQL1vIT5rQ7m1+FdJhAsaVtHrPwJ7Noa0Igx3Qp2a1ND
	aUWeCK0GrwTZCuwoFtrZ7y7LOrsSh+AzNdQ7zYevokqMVHVwlKURtTZgLHDB69cDjV6qxhqs=
X-Received: by 2002:a17:906:9f89:b0:c46:645f:cedf with SMTP id
 a640c23a62f3a-c4d3546bf6emr55329366b.15.1793914611758; Thu, 05 Nov 2026
 13:36:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin> <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
 <20261105083712.14847dcf@pumpkin>
In-Reply-To: <20261105083712.14847dcf@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 5 Nov 2026 13:36:40 -0800
X-Gm-Features: AclHuK-4-3cdEVpuwe7ZR8h4IzWEsLs5z4V7r2FIsMuL4z-PpEQaIZ0fXLkqICE
Message-ID: <CAG2KctocE=kj2CO29D0tVmrBeWmCDYA6FhpHr-7ZbD63GM1CsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:37=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 4 Nov 2026 16:05:52 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > > I think it might be more sensible (less pitfalls later on) to return
> > > the symbol number - not that of the next one.
> >
> > What pitfalls were you anticipating? If the current symbol's position
> > is returned, userspace needs another ioctl() call and an -ENOENT
> > check, to learn that there are no more matches. Alternatively,
> > returning the next position means every call pays for a look-ahead,
> > which for an unfiltered query walks the module symbols even when
> > userspace only wants the first match.
>
> I was thinking more of the kernel api.

Ahh ok, makes more sense now. I misunderstood your previous reply to
be about the ioctl(), not the internal kernel functions.

> The 'position' is just an array index.
> So a 'read by symbol name' would return the array index of that symbol.
> A 'read by symbol name index' would return the name (uncompressed) and
> do the lookup (binary search and linear scan) to find the value.
>
> I've used a bit in the 'sorted by name array' to indicate that the
> symbol is a duplicate of the previous one.
> So checking an 'exact match' for being a duplicate is cheap.
> But for a partial match you start needing the name buffer to be in-out
> on the read-by position request.
> So you start needing 'read by position' and 'read by position with
> name compare'.
> It is likely that the caller will need to validate the name anyway.

Got it, thanks for clarifying! That works with QUERY_BY_NAME in v3:
- In the UAPI, the input query string
(kallsyms_query_by_name.sym_name) and the output matched name
(kallsyms_query_by_name ->kallsyms_sym.sym_name) are separate buffers,
so the name buffer is not in-out.
- In kernel/kallsyms.c, the vmlinux lookup only needs the two helpers
you described:
1. lookup by name/prefix -> index
2. index -> uncompressed name + address

> An 'interesting' idea would be an ioctl that returned the value of
> the nth symbol along with the name of the n+1th.
> That might get confusing though.

Agreed, it's simpler to have the ioctl() return a single symbol.
