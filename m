Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB83EFFC5
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965600; cv=none; b=odHpEDh8NDiQY0gBkNqGNcrapsOZ/FLVhMHYEwR/4PwoFE+tl7qvxm+4/kGA/67GVuabcX6XAGdfIYvEgp66wKaJFGGEiK5fAp0hnwrL0XmipHzOsz6i2/4+ewRBsD1TwfrnAZYaCR/6thTUPS9eJjqCKPkcrXpLY6nGgqzyKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965600; c=relaxed/simple;
	bh=9McM4D53xdwGjY7hY3DU/5iPDJq5djZF76yWFfGlIo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAB17he2UUMF/ERuWjEhkQntZtt9m24Qpap6I531h62/hKw1jON3DYuAwLa8/KxnpjRhfINkcGvYomUj71o/5n91v1ncAlOyk0IkF8Dc7CXIWeo3Y4UcBB0dBUr0WJWSVDtb1qIzj1IP27vyC2CnGPzMkJABv58ZOcz/iCNSZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqralLH+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqralLH+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so23373035ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965599; x=1786570399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9McM4D53xdwGjY7hY3DU/5iPDJq5djZF76yWFfGlIo4=;
        b=HqralLH+J5M6aGtupHPXVQYE4iR70XPdgoQs8lBHV7E7IFVrtTwmP7K6BGlHXF9YF2
         vnRhqZo3SS0KFOths87Cwxi6H0u7S7ZFcSTLRkKgP0fvufRqGSPwkk9vOyYzCtUhNejq
         S/nBZkesNEpu1XQWELdRiJX7Lj4tBDQZO/l5UrY9DXfjqsvzUZ9BOFEGYdSljp2DX6VD
         qyigS0UDg1ONeKrUW8AhCQ/RljECefmMbEmAO+FWNB1fM0+CvPuS0RVH/1nyj+03iJFR
         YCKzJpX5SpvzPsK0rPpEPUH4OHe/3aiPpjaxDpT0QpveST7k166fPfg7Bk1f9bv8GR3Z
         v3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965599; x=1786570399;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9McM4D53xdwGjY7hY3DU/5iPDJq5djZF76yWFfGlIo4=;
        b=AYhtarKflfH2yU9LMDp/MQwlInjpladVaSa7/XSz8mGDQomYhTLaRRE7/0V+UgoPLB
         QOSP452rMnViKThbhuO5bxkKinJQiMMpDeELe1DPuhAXdBvR4qjnq6BlB4wazdvLhnlD
         O++rDtf/TPZbT66CMyDwssM+2RsCNe3jWX2UKvxcjMPeBLFIRTH1I9jGG6yFg5NZijLl
         z60/pHe2HanSDDLxq3zyvXOj9D/jZeiiYQn+DiPB288mTvP5uDcQZ3YKe+ELo8yPSQa2
         SW4teKlgkzyg46p/ulzS2D3ceLnA0WtJIsfBB7ypcJSL+yCo3PzsHGF6BC7uxcZtEnbS
         HVFg==
X-Forwarded-Encrypted: i=1; AHgh+RrMwttY+DYu+to4oJbYbdvdEa3J89l//oGErOtEk2KdpLcUOJFg+ubFaM19PrprEzEGrck=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZSDmjb9Fn9G18sEy8QcI9+YKQ7va3jDdnQttOEE1OHIgmoV7
	glos2bPqDq53r1m21SVb3dImysL8fbeURJmbWDhgd0mAWbP3TbZBze6a
X-Gm-Gg: AR+sD10mVQ6frCgpHIFolW/jHBuwFO4jvkbVFvTgyC/H5E1C+qnJOC5C1eOJyOKfM6b
	6+WchRl4Nh+3VnHQWHLE6HvnBETVkQTQp/f+hA4GyBq5pmjkWXAi3AhKQvcbcs2U/GrB70N/0WR
	UbPOcVJt7yCMNsXHqeRwZFa0OB85DKb30X5J27LwE4ui9hPMiGsDE+assrhsclgH8uqSMDts4AK
	C3w14sAogSMIAgJVajnmxESB/ijhmF7kGxLFd3SZjPKNKriG9UNzfVwUwahijEV7vIjZkyn8R2M
	imst/m9yAgiZwX9KQiHWOH9hElfYlEBVIq1v56CgyV1o6j/W8tabX8zF63DolHp3EikMTsO2Bdh
	2kNe0rmYBPNhfUl5cXvU+lF7rsZG1BS/rh2MFYZZ9OM+afT3Fn+4Y5ZshRgCAOSaRJCfVg5hpr+
	I3+BHPzNpRqQkV/b5v9SH7RTOiX7pZ5plf2eXFQkorOr4mo5tmacU1fQGpEG/b7RU1LifQMZfCD
	ztcnfg4OCgnh1wJtgHXCzK+fOGsWLBllXXGPSTBnHJmVH1cV/APnsQ=
X-Received: by 2002:a05:6a20:428b:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3cb85ef9229mr12398617637.22.1785965598694;
        Wed, 05 Aug 2026 14:33:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586777bdasm20276463eec.22.2026.08.05.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:18 -0700 (PDT)
Message-ID: <3eb28c78058907606ea4493bd59dfe29d5d53b6a.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 14:33:16 -0700
In-Reply-To: <20260804170156.1709916-4-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
> With BPF_STRICT_BUILD=3D0, eleven recipes append the same "|| { remove
> the target, print a SKIP marker, report success }" tail, each spelled
> out inline. Factor the tail into skip_on_fail, parameterized by the
> SKIP tag, optional extra files to remove alongside the target and an
> optional note appended to the message - every call site keeps its
> exact message and behavior.
>=20
> The permissive fragments of other shapes are not suffixes and keep
> their current form: the rsync --ignore-missing-args flags, the
> missing-input guards in the skeleton recipes, the link rule's
> wildcard handling and the test_kmods copy wrapper.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
