Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207383;
	b=rwUw3Mv6HNFid8Cffz8WVXdgcAQEcmXijqhhj2o99N4q+fYjwrBmkP8aYtCPP9DOQgqn
	 rOI6+6ndFV9vToHIZOefvOyynRB25xwvirPpADxi0ntWWdxjrr6QVo0WlY3fPlLGMEfFs
	 vihP5qDjT+tRbh10cHOw15UyUgifsBuCSWMlhYvX+M8gRfHhlskmWdQJefwybZjGiMp1k
	 8N1vxFnkxvOJWGP2VDuUpPLx662UKDAopSllC1Y199asFTDRuKisvrrtjfbYcXOTYFnjt
	 OAgAitz4eWHaGBJPoiV/YqOcsa09Nsm86BJqFVpdEf45R5zGo0Cp/DitYf4LA4X49Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207383;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=G8fdWfQoKSFg5MeXLSdTNeJQWSm1UpjIDHyYt8X2axY=;
	b=cPbJ0prwjsy3mgQ1mk1jfQOf9mKPjYktvcETWvBnP7x3LBewIygNjOQAEDifqCxnHBAJ
	 MBRQ4y4aOQr5gJiAUvVchBbcVfiolBgErSpSP3wkMmc77GtVKVC+lMtqHDSBSSPf+s1c6
	 5RXoJ2hTUq79R6saSgKih6oFC5lzDw8NbCDk7xxZb3bWZ5ozRmANWIHg7dUSwExm3wONN
	 6wxFOXAwGdZLrvmp5jukAgoGJVcVxGYX/eKWLcBUSGvx6At0TaNeUlMGihWKhf/a7yea9
	 NKBYykpnrlYQxsAYyi7tBGtaIvwcCe6piaPAbNwJ5xtOSpxjsjSKzS2/+JIBvlgQHqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9ED6074401
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A9ED6074401
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso17765966d6.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207382; x=1795812182;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8fdWfQoKSFg5MeXLSdTNeJQWSm1UpjIDHyYt8X2axY=;
        b=OtDVe73MEN60q906FpEa+y1pSR5PEqboBxCnk1pb6+uy/NFfpqM72uyb86q+/OqrSp
         a3j4Jb0YD6iAyO8fO1zkpUzKyGp2jJBhLYM0AkK0ohfL/swLrPTKrV4x8AWei8zj08G0
         qEJ4umwMvd/Pf0x7G3YXrXX3qV0kBqkUrx9WNhDq+PtWa+GZQtn7q7vB+26E1hC61qNT
         Lva35B/ML5u6jO165ojlTHlGbdMRqobxGEGhJlrLa0yfCB1J7b8JXclSQgDvq9HFVehu
         yty/Uq6fx3gDPZx0uCbivvJ4ggsdSp2uuhwbTKxIXD4JgkIciSQ35+KqBG8cJqn4v5gl
         poHg==
X-Forwarded-Encrypted: i=1; AL+hErHDUMtrM02/cbbKRfys3eApscc1UMPUiyk2EYBrzeY7L+QdHomTSJIpYB3OHhnMSJMdfEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sO+E/oFH3zS6/WzKod7BD5jMxIDFUeN7QWz6ZTKSRyQaDMq7o
	h1b0IlBltSPdaLrzU7nPJu/lhQJJaLP6UJokll30oF8ZbGALCYG4ZYHH
X-Gm-Gg: AYBFou3gF07vC7sM0Do1x9dPMS5Twhy22UJD5HobT1Ao4xIoFiFs6sAwWSzJrRmx8hy
	muree3wsTtMtizsFmaAw/wOCuKAO78vPYTXG1DpxFIiSqoy0ZLMTPjprbEpYsLDC7zVXQ5lhOho
	KYHgHHi0Ki/ID56RdM63H9JvC2GoMlD7wqSY5PlzemVPhG1A6xmzxgfmDe0n3+5kRHvnf62Vt8G
	CT5PsIvqWcrHeBfWaUTOORZGSgEB4mIyTfWV+uvgJN6bB9bwXSVbrIViNIjda+H+QMWppzni0l/
	p7qJuKWyTXnW87qSY2f6sTOWVbjSfIyXWqDIAZ+7Wwry60f7Hw2wXJrnh0nQF8xqSYfvQ44bhuJ
	j1gpyDEVZfwU+QegMyPxYMJTmulayZ5fomUOl2FumpOGXXZVxCHbiRXBpqEQZDI+BhNNgRfyPEG
	Mv3fZmxuofHZACMqYRQ/mh/njL2rDsdxWyGUy3EOgbrFt5UGvNSv1vN4WpEtPxc+ByeYrOLsB5p
	wQsxrDwZRnqF2m53IPnneQSmAoxWskx45vB0P4P+C6C/92VIM85/PHLgFLhH3O2FG45rrJAdr75
	BX5lOdHxemMIdmZRw+PC9XiTS7Kd5jBO2/GaxvNmxLE43bSJH0f1yqXGPqqtmjlYLWdhh5Y0Mpa
	8hDKkCDOM1NZOauaRXnAAjQ0RE/38aHCL5AnqSB5Z/q5IktmVCSss
X-Received: by 2002:a05:620a:6c1a:b0:939:ff85:8067 with SMTP id af79cd13be357-949ba9e9b81mr595306485a.30.1795207382282;
        Fri, 20 Nov 2026 12:43:02 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3cb882sm278211885a.27.2026.11.20.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:43:01 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 7/8] libbpf: ringbuf: Use compiler atomics
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711469.18576.16732977583563940939@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzay6HokFa2CTsoQt2SLQ-3WWC+EUe0b9KpT4Ju2TvBg4A@mail.gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-7-33fde039ddf3@kernel.org> <CAEf4Bzay6HokFa2CTsoQt2SLQ-3WWC+EUe0b9KpT4Ju2TvBg4A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> this almost fits 100 characters, I'd keep it as single line

Kept on one line in v3; this store is 102 columns.

> [...]

> this definitely fits 100 characters, let's keep single line for readability

Kept on one line in v3.
