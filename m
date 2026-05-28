Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3F3B2FFE
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973860; cv=none; b=YyIdZu2C1NvSAIkX8wcZIW1Iw/8/9I5tcixaP26/dNhybWi503K2ewOH5K0A2Kry4zbjCAv8wLAdSLmGewl8w6DtjSVwnfI3gfKQofsIxJPc0FF6a0B28PMxkq1a7nS+NTUrkhjnj75InNYWRNDhDEkg5/+MVrkd059DjxHjVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973860; c=relaxed/simple;
	bh=hQU8bYLEzZMXVdr4+y4jMzcfO4VnymMpNENMq/A2lxI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/5WPlyx4jGaFPg7jaOmrbp/pLexXyQgPJK/LI5pAA6SLqwGO4Ouj3vEFKxRESWfJozR/Yjlv7RWGId4hwOlWDr+lK+HDRTXP4zCR9eboe7T058LPPIhGkjVU63PFYTV4caOB+eqaPfvXVFLtdDGxG9q/NEEo70KeJgzVaa3Ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSR90rUK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSR90rUK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso111014145e9.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973858; x=1780578658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VlSFzU4OA6IgOgRQsNEzlYK5GF7bePvTtFAZKCHC6lE=;
        b=iSR90rUK2GeoeX8gJdEyZqEX8rvGIqCuuO6p1Z7Yv/xMYRifyd5MLDEvin47q3il4u
         pXlft5gr7Jb387T+37FxkQxqRutgtTq9o/AVsBr8dXfhpcq3W8yq6KOaT/JjyJSMqFO3
         lPm1GdIZCoKHrn0tfm1/VVRRS+3kZK6lJ8lhbxn5/2WO4Zhy17HKL2U4GdGAU05p0SzD
         fg+PHfWcNAtiVP7eoP+Gym68Km6h4vS3yv1VaxvqaZ9h+DdQcpdP+JalLukfhPh25ivk
         uqdozFsFriXax1fL9yS6Rxo0VAQHcfBK1RGeXp4VHIAhj5Q7VSrWySzNUZp/oJOixP0w
         LTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973858; x=1780578658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlSFzU4OA6IgOgRQsNEzlYK5GF7bePvTtFAZKCHC6lE=;
        b=g0QYO6vXTP+0SAazVug+6j3yhMZGcq78l/Lz+chznEVgQOyLuDMz75YZwyf5GKrT7g
         V+2jJT9i5QoixHaIrFaS0ejGpqwAorziLF0cNKh7gwZCXZgZhpG7+SyOjcVRYmDJNkvs
         H3gHdF93klebQuNnLKOziKKuCoGpvSxvA9u3PHFQ2nmUHaGS8V0qyDOkh7+7NsdVtIq6
         qWTMLDFHLk6yymXTmq7rXtoikj1upVWQk/ShPDFh+ttuX5WeO/swwY7SuPRFnSPHVduh
         HCcjhFhfnMgoutjvmxP9cZIaNZraqV8MHME9lSfL17Gx4Ycqy3hAxBf1yz6jYT5U8t++
         pkjw==
X-Gm-Message-State: AOJu0Yw+ZNJFHTdc18ikVEqH6vuOBMRIxuhHrNlfAS7YHrPYphmcEzw6
	K1e+DV6g7z66lgj82h6K1dZYl/H/Vo5blNzvHRXgUzg3My8jKTaYlPvt3qLnfg==
X-Gm-Gg: Acq92OGE/t5QC6PaQH4hQCory4ZKyxvOojLjHqNnbNFaZkBFhDOj94VMdjAOQQJdODf
	s24xoa4cf3Y2vuBY+FD5VFVMtGkpv6/HybV8iKGrvtIv4nNZOX2maK/rspI3txhR6R+gvRzy+fU
	OgJnt165wqeI4hiIprnGzHZyHH4/jDb8+p6fRnNTOVy83CXxt4zT4Dc00rV2u2ISWED0bxR3e5U
	MPpAqRRx/Le82y0hLNvdV5f3x9rrlQF/aoAzbosa4Cv+w1sW0Jp8+RuEvrtkI/kczZqDKYO3ZXE
	SfPX9+BqfvPQAOzqds8tg+nNozzVvOiZJf+KDctJiXkFbPotklTZLkJbrAtPOCMHQt3crBTBn9D
	q9Jb2HLTCi3MSmSFMsGmJF9l1o38tSKKU5gspM/k3wbsju1fXMZlmyPXC4yj1bo8QH1tOqZyDv2
	7QNXPhZhfc1LNpcaCwzCN9x2kVfoxXFpjdqEOa
X-Received: by 2002:a05:600c:45ce:b0:490:59cc:999f with SMTP id 5b1f17b1804b1-49059cc9aa2mr314163815e9.4.1779973857960;
        Thu, 28 May 2026 06:10:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909236ad1fsm42985905e9.5.2026.05.28.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:10:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:10:56 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 21/29] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <ahg-4LjsLyy8GqWo@krava>
References: <20260527113951.46265-22-jolsa@kernel.org>
 <20260527120154.9997E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527120154.9997E1F00A3A@smtp.kernel.org>

On Wed, May 27, 2026 at 12:01:53PM +0000, sashiko-bot@kernel.org wrote:

SNIP

> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> 
> [ ... ]
> 
> > +	ids = calloc(funcs_cnt, sizeof(ids[0]));
> > +	if (!ids)
> > +		goto out;
> > +
> > +	/*
> > +	 * We sort function names by name and search them
> > +	 * below for each function.
> > +	 */
> > +	for (i = 0; i < funcs_cnt; i++) {
> > +		if (!tsearch(&funcs[i], &root, compare)) {
> > +			ASSERT_FAIL("tsearch failed");
> > +			err = -1;
> > +			goto out;
> > +		}
> > +	}
> 
> [ ... ]
> 
> > +	if (err) {
> > +		free(ids);
> > +		ids = NULL;
> > +	}
> > +
> > +out:
> > +	tdestroy(root, tdestroy_free_nop);
> > +	btf__free(vmlinux_btf);
> > +	btf__free(btf);
> > +	return ids;
> > +}
> 
> [Severity: Medium]
> Does this error path leak the ids array and return an invalid pointer?
> 
> If tsearch() fails, the code sets err = -1 and jumps to the out label.
> However, the out label is placed after the if (err) cleanup block that is
> supposed to free ids and set it to NULL. 
> 
> Because the cleanup is bypassed, ids is leaked. Furthermore, the caller
> will receive a non-NULL pointer, which will incorrectly pass the
> ASSERT_OK_PTR check and cause the test to proceed using an array of zeros.

yep, it should land few lines above and do that err check, will fix

jirka

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260527113951.46265-22-jolsa@kernel.org?part=1
