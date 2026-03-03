Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94738911B
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568309; cv=none; b=n0OUJNZ9WqRUV2A7jNwhn9y626W4B4YEzDwmjvRuEPxEeI3lPku9tUx7wqRGKy3qm6mXUWRiwLEOzftDaVIB0jIrvkMWV+CfebkRztOJu0KgK2K0SsfNZ7swXFStGcJjgd6GW2F/UpwDysdgNNse7VOgKyftB7Klkg7ZHF32cCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568309; c=relaxed/simple;
	bh=bzPb6xmAmChlVP1q/WZM2tU9RBqtVAwunFB11U2PeFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDDixKtRYvppYeTX75WPW88Pt/d/a3hXGInThvCQ9Ya91ApfehxX35nn0IqexH21j3tjnS4vQF6ZZVE1rUMxCzVuP0bfm7ic/jenMkjEdniii10h26HRucIBnLD9Z/qxgKA4fTVV3tXfGfAgyTqLh/4m+/d1idzqc4aSULI9Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSIsRVe6; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSIsRVe6"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4b77adso7888532c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568308; x=1773173108; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HuHhGttXcFsF+4KHE6jrs5iwTBoeSrOICFq+9jlRCq0=;
        b=bSIsRVe6UZvWI4nIJSQTLM2z/mRTQTIzATYGx2TntqAnXap3tmmLkSLfW37VEEQPbG
         Coj+sog5Kav5y8SSyaTUJTA6XBN5UxnLLyn8rPIwHnAX0jgGUq74/fMNpRVCdS8eacJi
         BR7c2IwyAFQVkIC0I1fqKOSCe5D5d86/div2hvsGsHuUZq6FoTif1NdHDvxsmYISW2aT
         pQmQVZ9f6cjEf27FTX9rWYOIO7rfblQ7pV+3KMyzE0LCttzjxkcVe4Y4CddADgxf1pXX
         Nwjt5pgKaS94yu80oruGpIyJWOtuZjo93uFFToglgA+vlaerNDeZONsds4aDcA5iFjkn
         LLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568308; x=1773173108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuHhGttXcFsF+4KHE6jrs5iwTBoeSrOICFq+9jlRCq0=;
        b=FuorrTmW7LyXxgCaw8aHS4l+/ydc7ANOANwDQzGxP8u6dhASJGcCb6Tu9fO5GjWs8D
         xoM+Oqgi2YwTKjdfET1utjECfkWNUFb772lgZKvNRgoZp69F+P8czf4xtrEpV5uXjCmT
         8e98bucxCJBlBiQPR4u1GnQDfvL28432U7608s/2io2I1MkZnz9OjtK2LJEcbUxxX9Zk
         UYGO/DMY9ra8SkUe3bjAbJvj+7K8676ygk8yBdXkusVAqgDP1wJYxYgBgAGUfe3WbycQ
         oe0VR5pbEJK40B4G+gukp6N8jolyJ4Si/hCEbmn9hiyEmQkCZzPDjg/u4CbrrSCaypMY
         ZcoA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ofZ13DwRlAmpfKLZDzlTNaWLr/OvTuatKzDiVv/OoDErq5XJ+rOSoPKhdf5Bf/1MyiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxno7FT+QrcqC44Ubx1XChLJHLINLl8K0DQr4u5peK+R3agVcUy
	hz65AY40udaQj66Z4Zsx60uhu6g8XT5wjyr7CQw8Pm527fR4MX0MTkB3
X-Gm-Gg: ATEYQzzf3xffAbJzCZbygEBy29sQxXZPEACLDJXLc+VZ3wh6VyYWtljFgG0+79iuIkd
	t2kW4lNDig9NVJbE4Hx4Z4cOuyalR4VZrGpGxRY+eE0U8DCYZtb598HhncLqa4siQqjzJNGjfcE
	0FXzR0UU47K9Lxi1qA/CH//klxUB0/FzuTkHly9VQe7ppcY9RSk/R+aRx22B8LEWP18hvivk3AC
	UYr+0/Vbx4rw06hoCzHITB6ILOs/+mT5LTl3klr96MgDuAmX92PDl0hs6AqUPEZT/04DYHc3Rkj
	2yj/6f/Oqhybu9SZKyXfcMds1TG0bR94xX01SJy+a18bMuUUWy0weqbat7mYsHlPeO0OEvxnUv7
	xVU6QCNrc+B3G4xkIIZ71Siz7FNuQgJ9a5/6tnJEdspIHUzDZHhxlJc/F2HfKvXEM6/oQJ0q9HN
	BYjjlY+GWxNsud9NhkBC0LvTWwwIcTDT9Y+akKfWoTpXuoPpwIno9qHiaazVbRjSjgIvT2a9YAV
	89/lAiy
X-Received: by 2002:a05:7022:b97:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-1278fb6859cmr8038142c88.6.1772568307717;
        Tue, 03 Mar 2026 12:05:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm20207397c88.5.2026.03.03.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:05:07 -0800 (PST)
Message-ID: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 03 Mar 2026 12:05:04 -0800
In-Reply-To: <20260303095427.38981-2-slava.imameev@crowdstrike.com>
References: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
	 <20260303095427.38981-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 20:54 +1100, Slava Imameev wrote:

[...]

> @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>  		}
>  	}
> =20
> -	/*
> -	 * If it's a pointer to void, it's the same as scalar from the verifier
> -	 * safety POV. Either way, no futher pointer walking is allowed.
> -	 */
> -	if (is_void_or_int_ptr(btf, t))
> +	if (is_ptr_treated_as_scalar(btf, t))
>  		return true;

I'm probably missing a point here, but what's wrong with Alexei's
suggestion to do this instead:

	if (is_ptr_treated_as_scalar(btf, t))
		 return true;
?

Only two new tests fail:
- #554/62  verifier_ctx_ptr_param/fentry/pointer to float - invalid ctx acc=
ess:FAIL
- #554/63  verifier_ctx_ptr_param/fentry/double pointer to float - invalid =
ctx access:FAIL

But I'd say this shouldn't matter.
This will also make selftests much simpler.

> =20
>  	/* this is a pointer to another type */
