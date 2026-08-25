Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E338332F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640349; cv=none; b=XlXX9SCpIuvEfm+KbIpcCcYsK/izB0wHkonjphNdCU9vTTbSnUq9T+K54dNYw+lnEEA063h8spR49swTFS/Rx70QEfLG4TpwAk7uyCa5oYq5GMqhBy9r8BOwB45GgVQY14M09kCQzfenqTJYR4oX+fYl1sWFgrmpk+GZV2WSEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640349; c=relaxed/simple;
	bh=XcY/1tVTje1RPa4d0TNZYlkVE5JfMK05oLp99AUk76A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ImRsmQe7MWz5MkXGf0YA/psbxcI/R6t8f5aa5Lw/Dcg6vApyC8DCpkmhJaCyl9lPeScCIVBNxI/VvBq4D/bedSGqNLp0Aa09mycHrKbHJq8AS3r3YgFvHhQtt/F3yALn/qN1WZTWWeLsfjN5bbI2qLM6okiIZld1RLQ9QMMIJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpAGVf1b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpAGVf1b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3581534a91.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787640347; x=1788245147; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f1RPQYrBNe9OxVQgQKFmRs62wNX7lJAOMGeE+hYnR7M=;
        b=WpAGVf1bSUcnzpyYUeXnwsshgSpmpq3P2HKgkqfHeqte6ZY2rZXgNLp8BjTm/7Rdqw
         lsGMFvE1zUrB4Wn2rHUY/886jmhuwdfycCoseCjn3Opf7t4MEo9KVjw3sSmBL0Xj290r
         4rMawwMUdBi0mLQDo9reN8mVUyXW5Qb1zMq47RnRHZuEGJP1+1yD+cIB/oeECwtDBMz4
         FpOZBTd5wkGbyxVtk9Arr/BJ8Xu7E+YrqHw/i/+V2FIyqNBiUNPuz44RSYtfr7fzuZCh
         OY73iC03NVZM+x8hj4pohwzRY1YT9axQf4URVOhAmqVdVjBTPr9mBAPlnXX8egZSvKsT
         NUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787640347; x=1788245147;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1RPQYrBNe9OxVQgQKFmRs62wNX7lJAOMGeE+hYnR7M=;
        b=bNGr6c7qSkNViVkMTemLg1LiEZqx8M4VIx1Z9/SVwxK1vHCsHkO/dEk7qz1qvdB6NW
         nQq33JrDiNe8PDgsPDFoYy5AqO0raXUJlA7ZpkIY+ieVtX2ckRqx4H73rlMKUzzig51w
         1605o3+pBcawHRcZUoXVNAZey5HO3wOkBlFmB7AVzFlonvbj/5tZw25YgFde7Ablfeli
         iu8IC3WOT861fWUF7Io79CYRs2EzEh/TJM+0ctYho7tGfTK1mQtM8IADzGJRXqMCIkeY
         4KYIo9iVRoREqAGfAdDbWozIjyS7C1lj77DztVlrvUOr26MKROZk5LnsRDtK3hmgKiOc
         OL5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpUx4DrYin8Lpqvtb+FAyvui9FTA9dLKgUVuDP+u8MV0pMa5PCIfwy5S41ULT2rXXvuxAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l4oPiow4+jOppwo4ho+q5ItMF09Gmth/d/FTSkenYYWwvdSJO1
	HP8Puj7pgrU5zL884JXVsI86Sah9aVz1BLHWva0hzaTtLHcfGHVep6CC
X-Gm-Gg: AR+sD12oCS5NwJ9l5zI+qw3O46FC60NfL1bhWN1sF8Zui+pQca5G8HgpJni9CMFHfoy
	mdIrPF8cOIy8quNrJlk38LcCqRRic2QBDHd2QD2qRBHSJepzm0bhOCvQ6eKTMQRTCQp6tLURTFG
	xLAEsVF9YdYxnWJp6z4DT5wvonUr9pmIe6R55Fy61FnZjplyfmK5GGQOCJr7nbZvsWhDi5sWKxT
	DbdJyhvbdw9meHZTPqxcjNO9kBTQjST8ZpXfShGVLdCV73EiCji7d4KUholJXsrwcLXF54efWkd
	SKE3uSvvLlam7Xq0/xg/vj/JQikF+jYH+rxlQnrNoupQBrbdH7VVSTUgd88KgjQExCSLwSdvBoj
	PSi37wELUjg4Fjhg5BR2ii5+RyC56TLK0w1iVs8QoluKRIqYYC8QtVM62aEcRNAPitVnPwr7m7y
	7EmR0PysalBaBKYlIwQ9PRTK6h3Txto/CFt8S88mXLkt88kZ+2KZpHmBCygEIgmudMjW1ikI6rY
	fRNAFs817KxAGVB
X-Received: by 2002:a17:90b:37d0:b0:395:4de9:b30 with SMTP id 98e67ed59e1d1-39646350ad2mr9064395a91.5.1787640346665;
        Mon, 24 Aug 2026 23:45:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b4d52asm2690529a91.8.2026.08.24.23.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:45:46 -0700 (PDT)
Message-ID: <bb0c6668cc760530e098223901fd178b6d94dce0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 8/9] selftests/bpf: move shared build
 definitions into Makefile.buildvars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Mon, 24 Aug 2026 23:45:43 -0700
In-Reply-To: <20260823194241.3415152-9-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
		 <20260823194241.3415152-9-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-23 at 12:42 -0700, Mykola Lysenko wrote:

...

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 8ac6c8844d4a..432897613b90 100644

...

> @@ -185,7 +97,21 @@ override define CLEAN
>  	$(Q)$(MAKE) docs-clean
>  endef
>
> +# ../lib.mk appends to the flags inherited from the environment;
> +# Makefile.buildvars rebuilds CFLAGS and LDFLAGS around these snapshots
> +# so that its own additions precede lib.mk's, as they did when they
> +# were defined above the include.
> +INHERITED_CFLAGS :=3D $(CFLAGS)
> +INHERITED_LDFLAGS :=3D $(LDFLAGS)
>  include ../lib.mk
> +include Makefile.buildvars

Let's avoid INHERITED_CFLAGS dance.
First, it is okay to change the CFLAGS definition order here,
lib.mk adds the following options:

  -Wno-address-of-packed-member
  -Wno-gnu-variable-sized-type-not-at-end
  -D_GNU_SOURCE=3D
  -I$(top_srcdir)/tools/testing/selftests
  $(USERCFLAGS)

Before the patch these are appended *after* the definitions you have
in Makefile.buildvars. Making them go *before* shouldn't break anything:
- include files in -I$(top_srcdir)/tools/testing/selftests do not conflict
  with selftests;
- USERCFLAGS is documented as "additional", "extend", so there is no docume=
nted
  guarantee that these should override other options. I think that the only=
 one
  we care about is `-static` and this one should be fine in either position=
.

Second, if one wants to preserve the {C,LD}FLAGS definition order,
the following should be possible:

  CFLAGS  +=3D $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(CLANG_WARN_CFLAGS)
  LDFLAGS +=3D $(SAN_LDFLAGS)
  include ../lib.mk
  include Makefile.buildvars

Making use of recursive definitions for {COMMON,PCAP,CALNG_WARN}_CFLAGS
that are coming from Makefile.buildvars. These would be expanded only
after include Makefile.buildvars.

But I think it's fine to go for the first option.

Aside from this the patch lgtm.

...
