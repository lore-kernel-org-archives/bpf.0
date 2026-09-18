Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2A448D1B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736511; cv=none; b=XKOUyeVluI0NUeGaMtDt0Bh6jKx5GSB72w0I3NjmueadGwt24YZxiFqGBxRH53QIG1XrQEEchQuFMtUDdUqlczH9I6Mb4q7I5C39swua0RD+fajhLe6Cdp7De0wlq496gERcmu0jBCA1Kul7m3amc792rgL94Ddu6FxspUVxh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736511; c=relaxed/simple;
	bh=vk33DT6oYdr27H0ABDy0zm5SoeyGoMiovn3c0pfC03g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBm7gAi4saCR2PIW691sP4xbJywRtuzMS6C4WHesSgGjS6FJHT4L20CFg/Y3U02NbLSl5GRoud5DjlhIATF5oC+Q24enp3qg/MknVBZiAq+ya/xZAETY5LEA3zn9g0nk/xFCy6Rz2Z44/SUFH1o44xt21ekTLmkzEPZTTGWUvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az2wvMD3; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az2wvMD3"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so416993f8f.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736508; x=1790341308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fB3uyJdCO5kUP787PFgsM/g9CZeqrdvpQ1pOAfbY7C0=;
        b=az2wvMD31YOn4Q+4O4txCAHa+8NBLseHzIFYdWHIdQRJowGuBYVir7urOPP+BpgHYA
         kVcHcdMNs5ALMSCEBhSNTNTg73SY4iACnxOFfezzPQwP660JRqyw3fv8vX958GqosIj3
         YCDjYJ7JvnGHO14U+KlIbiE1nFXmpqXSpeyqGHL8s6ogCOshM4QZ9F2dfq1q5ffeVnnp
         BXo+aC8MDy6y3DFC0oHvBIPoE5XZT0RBcWz+nwX8CfNMXj3S0l9osF5lF0jL/J1OP7Ln
         sPamIxV8u41Ce+01Nciq3j+uRhk+JJLO3GdGAcftkWI/ViSuGybiC9LFzPZIMYjNlhUY
         BfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736508; x=1790341308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fB3uyJdCO5kUP787PFgsM/g9CZeqrdvpQ1pOAfbY7C0=;
        b=gtSOFxldWe8fHAvw3AVviAn4Zk+ucmFJLD9w9z/aKOS/Qs4LkGjWHXatxiTLkbgUFO
         jFpQOYMB/4rQVdT3w2Vi0PpGMp5lvOXDTHfkUArRX1F05re74cgzh8HWwglthFf7EnBE
         qL7ivNuIJ+hoqHAuQPJpP5YVQ6Deos4OhaVgv/Ln4qGSKlG3rQNXrjnLDbgoGJ83TdqH
         maFCkwPnvlbAJ6luemLrTkoZL9T45yt9BH/dg1+8Y9a18FxhEDcfmM32WDIT5PFOSYWr
         Tz+wALO4kkwYfkFv/lv0t5EJHeL4pejYmEyAn5+Ve/+WOBjtmEXQN0YTN5z08TRr2fT4
         tnkw==
X-Forwarded-Encrypted: i=1; AKwUvBxCNDu7OHkVNKS5XFvtQiML4it9nPaqehtYKctWx0450wShF1s7fUSVuXd8upEYftnb/kE=@vger.kernel.org
X-Gm-Message-State: AFuF++n6RyCik5ryc/Ci16/mVhCe52jh+HoXsJoIaatcl30jACc/BxPc
	6bC2LMEpZPvNET91oV4HjjXRxC9qJBhIr47l1iIszUT0QjRvTKcbP/ek
X-Gm-Gg: AYBFou3t9gntsP4aK8nFr1IV0YEqz9bM77hAMrlrxiRRNr9f7U9UKdtYdtNiwzctNIE
	KQSdsnCHzTwvU+24zqhpDp23zVBMqX7MNDtcQ/7Bg+j2zNThWahk1A5m+4noQKb7fhloz3IILDe
	FdY+Vt0Xto1A4cHkoZgiPDHMrQyrOwtwAyqSPmU6H7/rDZnf3JQPVNWCvWzn+xrSJuu4hjtlMKb
	VAU3zaHGzCDOoALIezuQshdknwkZnK3+Z1aAoj8sf3JSOXCzECoIccco4xeTtEvBD2PopUxJMZc
	icaduaK9I0BONKeeqF43KXZDbxpfpdI25k0+E4OJoH4Rml3IBSPbfpP/UzGwWak6VyjBPylqv8/
	8kc4VmdJ/EbZYxbDX+rlyBayuQhIqSY4CVvIn0BAcXqihB4sWuSHWyLn/kf7uNhivlLKNe0tGRa
	yLknGxo+oII+bps+reyV9DCu//IDPb5oY6dERJKwSg6T+9sc0tc+kP8ySh4Q==
X-Received: by 2002:a05:6000:25f5:b0:487:7fe:e96e with SMTP id ffacd0b85a97d-4871e216e86mr3311289f8f.21.1789736508346;
        Fri, 18 Sep 2026 06:01:48 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff3a928sm4292118f8f.13.2026.09.18.06.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:01:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 18 Sep 2026 15:01:45 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, daniel@iogearbox.net, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
Message-ID: <aq02OQvU2GhTwHWD@krava>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <aqsTCF4uGmN5SlZD@krava>
 <0db440b3-f39c-41ee-bc77-4e3d2ef2b95a@oracle.com>
 <aqxi4p_xlBTSOtTf@krava>
 <f5167878-54e5-4b89-8ffa-bc48a96fc651@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5167878-54e5-4b89-8ffa-bc48a96fc651@oracle.com>

On Fri, Sep 18, 2026 at 10:19:33AM +0100, Alan Maguire wrote:
> On 17/09/2026 23:00, Jiri Olsa wrote:
> > On Thu, Sep 17, 2026 at 09:27:42AM +0100, Alan Maguire wrote:
> >> 
> >> 
> >> On 16/09/2026 23:07, Jiri Olsa wrote:
> >> > 
> >> > On Wed, Sep 16, 2026 at 08:41:16AM +0100, Alan Maguire wrote:
> >> >> In raw mode ensure we can dump new BTF kinds in normal/json format.
> >> >> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
> >> >> const value of 0x2a and a dereference of r10 + 0x20:
> >> >> 
> >> >>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
> >> >>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
> >> >> 
> >> >> LOC_PROTOs render the associated values of each of their
> >> >> LOC_PARAMs for easier readability:
> >> >> 
> >> >>   [14] LOC_PROTO '(anon)' vlen=2
> >> >>   	type_id=12 value='r1'
> >> >>   	type_id=13 value='*(r2 + 0x10)'
> >> > 
> >> > nit, AFAICT these are dwarf's registers numbers? could we output arch's register names?
> >> >
> >> 
> >> thanks for taking a look Jiri! You're right they are DWARF register numbers alright;
> >> the problem is to render them as arch register names we'd need to maintain per-arch
> >> tables in bpftool, which seems like the wrong place to host those. I'd suggest instead
> > 
> > is it that bad? I guess it's just simple fixed table
> > 
> > not sure how useful that output is with dwarf registers, you'll need to convert
> > it to arch regs anyway to make some sense of it.. we could save some tokens ;-)
> >
> 
> Well it is a raw dump; to draw the analogy with functions, we don't we print a C
> function prototype for a BTF_KIND_FUNC_PROTO; instead we print a set of BTF ids
> that comprise the parameters. The problem with converting it is it then becomes
> hard to relate the raw dump output back to what the BTF actually was, which is 
> often what you want to know when you're doing a raw dump. Now that pfunct supports
> split BTF I can roll support for printing per-site info including registers etc into
> it as part of the pahole changes respin.

ok, sounds good, thanks

jirka
