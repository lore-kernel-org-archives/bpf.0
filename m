Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE840DB29
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574373; cv=none; b=DLfKKUKrmeUbA1HiNWAWVFIA5WUeDuiaM23UNtMn9CZarAcaF/URrNjQ2DkpcP4SRA9woECFVegjfsu5elFW6Lax8LAVVYiB2NWi4E/ueadhkUVpiAuxt71hrIdqWKp0A2he6b2dghGwKPd+c2lMmwclq7FHO6f5/HmyyxBcme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574373; c=relaxed/simple;
	bh=/+ibtZfVhOlusR6XfSWvFqs9qwlfi4JTFLX1PAuC/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjE7MnL35WHdjs3azo0oLvFh4a7YWIaOkED8MXvCDXy6r4oFMafZD8i+yv5p615mC9e8TuZ5DmE+X69wv35BnKqA2bUFegERyY7gtNDDc3CP1D35BBGy0HZV6T3k/NUeAyL2FGvS1rJfvV/EozLbXJvgU72Urna9y/+qk7I3A2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IQXo6jYW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IQXo6jYW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15b1da6b82so358693266b.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787574370; x=1788179170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HiNLXqPQtkSfd0I+8Qv+U8OwvNuLKuIdd4i+Pk8Ei5M=;
        b=IQXo6jYWdvKiRfRtGSdClubgd8llan1X58q4zPFYgLLZ4jbwyBbJ8RTQBV6vzI1SZs
         bfH2ASW5eSS3qq1N+5/Y4fQ9Z0uuLQ8R8SSh/IqF12l/k9uULv6rPif4kLjk/uz4BUiD
         4UkndRCG0rhQXPwQvUkJFSevJpF57ILghPQq46JUqT1hiKuAQj/S9SHdqdTk/bRvYlKc
         roS33fT1TOVQUWuV7IPrlGoyxjpPh+ST6tWvz3QPwOqG+kdlCvMjXbyKc47WYZGiqn49
         s+awgofDxE7tA//tj/Z1HELpHM1TvAtxJIoyTFzmzVZ+W1niIkk1pli83vxkT/XJrwMV
         5A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574370; x=1788179170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HiNLXqPQtkSfd0I+8Qv+U8OwvNuLKuIdd4i+Pk8Ei5M=;
        b=eyeTnt7KkksfmC8RROgbREC+qOaImKL4lAVKmZYpShwbkpqegeVZi+zJV0HVl+34uT
         +mGMpT6gQhAiQvGJhskpu5cJXPkhSYt6jYcAuZpXqDvzEm0b2hgr5TZafw7uXPA58ij+
         1A6Dr41elOBCOrtZh8uNrFBE8F18lE8aB5bYAp8+8Gn8T/nWHiVDMQFG/gbZ/l6CBD3Z
         0oDfBPlhOmr3uEcJayB/MHHWs/qtulb+OdwrleiQC1zzsgQ/gj9JFFAzC95Vy5laI59p
         Seimf7W4UmNh59FcvdozEFZO99BD7bEZLxT8EgRKnuigxHUH7/x9Ul5FS5L9k+jwa6b/
         Eobw==
X-Gm-Message-State: AFuF++mSJPu4ZWVJjuZgeWr6RrDsF2+6KMja5QwGKNpKhNP90UBcZ1II
	PrON4la+ozJi18ZXsTOR9U6P0g7uXiir0U+nR/woW8/ud8A0M+uBKuunt2BB1lOSwvA=
X-Gm-Gg: AR+sD139XscN8m8516+7JviIGPm3tkOCfvhTD9k+Wb3bpol3GaQgnvvk0Rhxhx2zHS+
	ox3J9TWo00AP8unallQzNjWDu9SRQzJksjOAwPZzzbrKPtC+4hzH9tQOWMZ7G9B4Pl4Mp6Ynv0q
	1zrDOjKBxojZxNk//lQPRXTRiHW0SLO17tNQ3woT0HLcsA6O5VZ7zrof8ZGA96CXl4QtIg+E7uZ
	Qz0CRwIISxmzllNTM8bGiP0peuRvuIAxumZC6VSmml6IqW5b9ohyf5BywemdUQMB/48nE57UE/3
	Zj31r8qWLng1bsZ6eZH2flUIXjljCcjjmArSxXvioDUf5nkjj96lAjJm6dkd357w1S/ONrG88a1
	z5j8H2DFIFRu3x1Z1Gjzgv8zP+TAvWmv6DDwtOkVeGNpTnCOHOzwK2eWmrmfi/b20by4PyjbeFq
	QUmgEl5eOp/PFsDJrqeIC2CQMQUCtrtW57Ss2rL4QjnRjo564P+BFK7o4cvprso+v2K85b/2Cde
	g==
X-Received: by 2002:a17:907:d12:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c246a6b0994mr3185124066b.24.1787574370353;
        Mon, 24 Aug 2026 05:26:10 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24d8375776sm177761566b.31.2026.08.24.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:26:10 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:26:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
Message-ID: <aow4YNCDa0gDwbfj@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821050631.39784-1-jiayuan.chen@linux.dev>

On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> conservative guess for BPF program context that is always false under
> PREEMPT_RT. So even a caller that really is sleepable gets the
> non-blocking allocator, which never reclaims and never engages the OOM
> machinery.

I thought one of the main motivations was reentrancy. As you cannot
really assume the context bpf_map_alloc_pages is called from there is an
extra care needed so that this doesn't re-enter the allocator from bpf
program called from allocator path and deadlock.

-- 
Michal Hocko
SUSE Labs
