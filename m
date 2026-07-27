Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A829898B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177448; cv=none; b=Ic6XPadtKX0uJ/nxHWcuEyAQxCfw4DfI+j7lHoYA/2ramO6Nav9LmfmmoKeZO4+cmOezeqQ9N4rnXMfOR0lhgBBKp+1kI0W8R2gHduPmkbufBRy1LLr+9KpEQpO15ECo4AFYnVn1X9axjn0s0qpS2cyZ6qi9uD0xRt8hr/F2Zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177448; c=relaxed/simple;
	bh=TtPN8aCUQenMqqIbbZdXHz28B/vAf+frwqt5lIMsgDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V56E6zz5jsfsrwqhBYHXqUArE4BrPX7yd4SiovjUDsR+wsbmJ8Tf5FoTkAv0JuDlGShPmstGrYMn2avZL5uSpAi7HzlQ1iA6YZ++hXMJ5cAnzQupa1+/ZDovvM1loVZR/GbRwJxdjU47xuGVJd6uYH5iZAXnQadzQpVZoOMqMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIyMsheO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIyMsheO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab973140bso40929445ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785177446; x=1785782246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TtPN8aCUQenMqqIbbZdXHz28B/vAf+frwqt5lIMsgDg=;
        b=JIyMsheOz/4m2yPqLiboIfS+qtv00tcbUPIZLBGCQ/zv6UVsaPFwzJ6LCADjlaD8Tt
         ++nVSM+uWqLYy7VWPPcjkTqc8VyAMVsV0CpcCKJcrb4xas/zWEYbb9iMC63qeASpPUwh
         /Ti/gysgS2Ttqqp5RED1faZxENR+C/yLqJP9pfVNwnrqR2gvqULcC36105wDtiKfLz+q
         GENnOuOm25vZ2cX0j3CCojyrKz2ZhTX5s+7KRz/oCw+7uhxvAaLSvmZ+vOyNd95fdc61
         t9s3pO7hQfPqEpAM7LKvXbJ/d3Ip4jw+FqphsKEebPRNd3FLliFxnjwumsCmBU69fAz/
         nWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785177446; x=1785782246;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtPN8aCUQenMqqIbbZdXHz28B/vAf+frwqt5lIMsgDg=;
        b=jZY5yM9H5Bkt4cDSW23e0lmtmypYmIhpDVe1imcTVPbNvCxSSRvsfq63JmCAEdkZ7E
         qRQBZ5lSYDeNzNueRKag1mYRzsMgT8etEaB4fR2zZLHmA6BgmIHYpRI5ShI9gTroVqPm
         kpyRQZIlHXyRN8RKvJ9ShiH6XjHQV59PmRaLYH+xIvgXFL/MahvMac1lx86vOP+gpAbk
         SwHOWUmpv99EP8llgr6zA4/HMiJPC73HZOQ5eWXqZJ8DME6l0y8oa5Pb8iXoED6W/CEV
         0ii1QID/mYDORRrjHaQJWAYI5ygORnPwAahAb0Ed/wvCoGepL5OzRsTgKNadeDsK4yYW
         /o6g==
X-Forwarded-Encrypted: i=1; AHgh+RpuuVrzzDl+s7t/EP58YQbP9e/7xYLLStgXSWx/DrUcNjd7otdDJuMWp9eC7iKLpKV0N+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASgvF3qKBangw0iuwJEsXGstABbRgj5C1KS394anTZcqCsOb/
	nalw5PmLEUPT0IMatxr/N6HPPfcwzHGc9TnoQ4KGKAzCxHdtSBKEO6okpI41vA==
X-Gm-Gg: AR+sD11ECmWjgOxlVwBSVkM1X1A/Lz7DLOXJtAq4cFOgP0FhOyiPki821VhzTdD2Q1G
	+alnKkJ/0GdGXq/ytv9QUjlEAbLxQc7cblzIPzafFAe4PnTSsW4+5EKtI5ynrqd3fp0xs8M3HXs
	WJJ2a4Yqq1Ks98LhKZfe1gotstKL+vff1P5XWqxtIbPUYCJgsaJxAnnYiUG7byESLkHTni+6OA9
	86iOFDanH6imvq5ycbJAIzsVfJzmFbVk0UkPUmwkZZqchdDb/WvvWzAP8bLieMMNyXpl0HwvIx+
	8YdHQaMJlTxEUahUJDO7dLy5mMiMDWcVX3GHKRCmExqO+AKvvIZRVdlflUJJSmARyJ4P6qXOwUJ
	E9Ye81IkF32EltM8VUMOXz8UA9GyYke9M022p5p0WYJumviPuSnohRntC/D3r1yT2kZ9T7AMM98
	DwBuWSd4gGCjhmNmh6xYumA7DcW4Bdzw==
X-Received: by 2002:a17:902:ffcb:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2cfde78b6ddmr93672355ad.4.1785177446313;
        Mon, 27 Jul 2026 11:37:26 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d5297sm39941085ad.56.2026.07.27.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:37:25 -0700 (PDT)
Message-ID: <4c4b96843caac639112f6e34d271480ad213cb09.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/18] bpf: Pass kfunc meta to mem and
 mem_size check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 11:37:23 -0700
In-Reply-To: <20260724190813.1458271-5-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-5-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> kfunc now shares the same bpf_call_arg_meta with helpers. Pass kfunc's
> own meta to check_mem_reg() and check_kfunc_mem_size() instead of NULL
> or a temporary meta on the stack.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
