Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40015518147
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678612; cv=none; b=iT3pByGguijU4130EAwnakG3//QJQEmZ0ITxDCNg9lKLlC9MVz0Aq3bsdLjG0Uze1QiNcRsiDXBWPSKEicfYlrTooN3DlLTg3Sh5GoBh1x8d1z23X87rOseUrKiFbbNJnXxVk2IoJmCUgwopwH3AOPv0BaFmjCCQOXGAMdNaYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678612; c=relaxed/simple;
	bh=zotbPxKoc7eaZeiHEyzpI8+4I0OpAPBxNV87xp9qI4k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=rORrXwE0VyxiCABWi7/ZUOxERVuUH6lF+pg4yt8+5STGXObU0e7VJnu1SJIuknkzeDU4L8B++psmT3VDIM1gvedoYOtfLscLqvg9gYpKrtN7ipBOASzuztz28faHBElg7la2isipdNFmuzJCRLZGnUKmOzTgxdcqSR/XepKMV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSgffSUq; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSgffSUq"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d42b972bso792655ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790678601; x=1791283401; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tiDU7Ym3H38LfGIFBt+oGKfio5R1/6Nv8WVS2Iwwlwk=;
        b=kSgffSUqCQ2Cov3Io6B0GR591l03vXM7w66vUMhheiTd+3ZH+lhWs2grYD2V0Zaja6
         Y9Yd7jpDq9t19FrcoGWTI2CYFwsgOj5oQbVxh8ELWowld3tdMr3zvxVwi3ma+q+Wj0vY
         EbOoyTrK6Pgx57LigyGZr9miDQV/IIEZ7OwNsX+c9AYRNkptmKSziKe4wJez308slvgr
         +xbrXH40O7zXW5WHcS29gWgfaY2CcT1v6TSyClxlMfJYj6wiDJD8RdVL62oa8CQ2XOy5
         ghfOOOYBIqkpkzH1kuL+LOX9gEZOZG2TUsnchMV/Gg+nVnaOHjy4qH9m7QqVpq+dvS+7
         deJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790678601; x=1791283401;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tiDU7Ym3H38LfGIFBt+oGKfio5R1/6Nv8WVS2Iwwlwk=;
        b=2ROOe2HvAAFo/Z0zZl7JueVZqjLW+LeFKiAJxI8C/ul6lDPcbJwqTfVww3kQb/456x
         9sliToDgmfwZcFICjfVF96U50XoMf/VyRRhZW7q8sFAWlbJMHIo0G1X2XHdY/Mn56Qh0
         rNSFjjZdhOwKgy1dip97URPW7PtlS++F8KI5KzxdYKxPeSnBa2k0eHOLaST92iJ+SC4j
         t6psvHXHxJ6PR3Ronk5cRrTzp71QPm6/swkIXUpmB3hQavosEsFrROSiM6L2STnS1s1J
         SyiIPBKTGJc27xl4s9/J9OZdhuIAmNYMEkacisfYoQISs9gNAFRgbSS86mhyCMy8L9HF
         eMoA==
X-Forwarded-Encrypted: i=1; AKwUvBzUPS06O1FmdMV9nCqKiD7BRGRDl4Rs8PRq+3dperWe+H9OmeI3Eza4XPheiv2owSTwQpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYILLZhajkHXWFlF/pm4TWAB527mU0T3RoJfA/CW7JUFysHudvKc
	3L+l9PddCdQEwVvgCyUNSds2fWLVCRIz8R4PNJA8Nj90hXrMjzllt1U8
X-Gm-Gg: AYBFou0hoKcvKsZml9FlaJXlzyrgw8ALhVnd1/eZ8kwsHtutf1cwt9nKRNr8bhOOApR
	4cz5KBMdR9SD+SQNZq/prf3ILwjIiUK3adg8iTA6GK3xsBEJTvcr+CVyVQBaKnJ599a27ox1h8U
	4yo8vuntTSYVff1Vu819cXY7tXnNf7nu43Q7uMTNUPMxaCX1nGBRHrUcJqEv8rCBCd8yckHpx2r
	3ASb3nsd+DDulL1dNauYj28P8dbYaQNQB9lz0cxtjyzjVtMhGZn4bKqr7cgYvx9A5atrIVy1z0W
	pcszA2srbzH7Wl2LyjdoDAnCLUf+HMFnczNM5diNsx3a6LNf1dMAd4HeX/cuUKr7pIvPQzLqP88
	PZV8YXWreAsStc0eXUafurpnT5G/QgUGKef5smMGIFXQmzbqqGwTdxK5DlbSBomRlNJGZdC7rBM
	1RTvIWDGla7Lwp6rquqsdGLRp/VEXyFctsFLYS/WX/BhIYBikzgNQxCZE1sOJA+IIY2E3VmCnlg
	AVJWeghgOvJSLNHO7TO+XlpTIQ8wyWdtU5HqYk+KX2RF8CuhM+xY/XmFd8KW9O2ND4AffeitYZb
	E+N1N3UAK3l26Fw=
X-Received: by 2002:a17:902:d2c6:b0:2e2:be61:a87d with SMTP id d9443c01a7336-2e2be61aa0emr24586855ad.1.1790678600896;
        Tue, 29 Sep 2026 03:43:20 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2ca4041dasm6474985ad.10.2026.09.29.03.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 03:43:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 10:43:18 +0000
Message-Id: <DLRQL3VZ2FRD.2JRCFNKOLT1P8@gmail.com>
Cc: <jolsa@kernel.org>, <daniel@iogearbox.net>, <ihor.solodrai@linux.dev>,
 <yonghong.song@linux.dev>, <song@kernel.org>, <martin.lau@linux.dev>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <nsc@kernel.org>, <puranjay@kernel.org>, <yatsenko@meta.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen,
 flags
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <qmo@kernel.org>
In-Reply-To: <20260926175113.2368566-2-alan.maguire@oracle.com>
References: <20260926175113.2368566-1-alan.maguire@oracle.com> <20260926175113.2368566-2-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 06:51 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
> +		if (vlen > 2)
> +			goto invalid_vlen;
> +		/* Ensure size/vlen are consistent */
> +		if (size > sizeof(__u32) && vlen != 2)
> +			goto invalid_vlen;
> +		if (size > sizeof(__u64))
> +			goto invalid_vlen;
> +		break;

size <= 4 with vlen == 2 is still accepted.
For size=4 values={1, 2} bpftool prints 'const 0x200000001'
and 'const 0x1' when SIGNED is set.
pahole emits one word for size <= 4 and two otherwise.
Should it be
	if (vlen != (size > 4 ? 2 : 1))
?

Applied anyway, but pls followup.

