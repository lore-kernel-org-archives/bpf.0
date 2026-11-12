Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508422;
	b=slJDPO3x4ZbuZ4hE0IrS4KbIR3vmUaPPOEJf3qaeMs7MAhHK5tx5JCM/fhMJlttjPNTa
	 fVhHAoKChLAGvyTh1kflSeeK3ZuppgRJdPXR7WAu+b3Xk9/gZGpDeyDbADYxxnba53vlo
	 SljyIiB7rEH7Va1WVrpFd4lUX3K4JD+tLEId6AiwwC54reoaVsCg7oeQibSLBcBoSBzml
	 VsaH+D88FK6fbCI09SW25e6V93eoZlzuDNDcKvxkxvT+pquLuALuRb+AzEVQeyxJz+iYH
	 pW9cbJVJe0vLe6Ye9v0CUhHRTGzy/+hvS1qbpSou/zxtz1gZYHFMkgZvg8y+X2RRMUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
	b=PB9z8XATmooygLcAhSeNLmJob7VoDQnvwBEQ3Ya+2fqTP1Bu6V+4VsBsaHaLlUCWYYFO
	 TxabqpY60/PYNhHpYmjsxRec9ouYDsY4Eb16nhBCLcazZPPw6gdzq2RG54VIOBSN2IZnk
	 Epno9FljNtWd4KaEH48MMTy+w8U2RGqWDdTNOmxGSVkumfGkSVKdEo1ibbUI97d47Q3ER
	 K1WGX9O8Z3UlslIzODV4DaP5wzcH5vqbJyxDJxlxdpC6hlRcSTS2I4NCLuZ2N3Rvsuc9t
	 qxf553cD2xRWUVR19yEBYbgTIu+tTnAg/9p9XtWDCdBoe8jFQBU9+512ErNgcBzii4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf1JKZNb;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7760A263A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F7760A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf1JKZNb
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d427836e9so6001066b.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508421; x=1795113221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
        b=Lf1JKZNbNbgUdMM2i2KIGIbtGN+MfqkwJ0BEbEAtwCtfxBUZOVH7reJ2S/aMnwpOHD
         t6ZIFrykOHl7gg2biAw87iqG5ymmiq5LRXRC/yiMl7ci6ZyYM07zEiDrNLUPVybHx+G8
         jR1P0st04yQMJU7CTIGAxQZYeJYA0Y8+IQjFUafrMgZ2Uz3+pXRVO78f3Nt1eSViDuCd
         7Fi8zK2myMJvHtIwPXUG1lDcf+s3BohEwCwYiqmKk9B4YxLHgBv0zcwvJWieh4xupz8R
         HxHCdtxbDr53eFZceqn4Qc4XXrpE9b7aTT8o3NfOxXwi1hyLhLcoBcoar/CocEGbaeMD
         I1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508421; x=1795113221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
        b=biVwMBH2bKieTbiAjpPsDcobbAceMbjJ8k0bsKM5v9c2Hcu3IOxZa7MU9UZFQDiVMC
         7fsFHg2n9iY0AeIdH+rTpphJu3C0YZPlVN27qoK36CytWmoXF7KFLilGEOzxpUV6MBxb
         mFVu8kxyBuNYI8Xabb4hQIKJHgsIP41kRaQbKP2weiX03HFH6m4bwcdNG0cPvFiDNQlg
         bn8kJPR+fMNw2IR9DeU2YafODw3Imd4Y9wOdAiNRAqx0sW0ZzUmybysrBhsB4vgXWwcw
         GfRVMVLaum+Xp78Mwt/2J2DHar/wFiVD6WC7Sg+RBrw9Zbs2Yufxsfhzs4jHYLWjVtzl
         eptg==
X-Forwarded-Encrypted: i=1; AL+hErHsj7ad/P3tuC708GBYW5S1KWbkAvyRBezWfcwgCNL4OVynxr4FOLFFkavD7KBLq8/NF8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LuVaUJD8I+v8zhoWrrUE2u61NZJ9TVGN5a2YyJgbh1RTuv8TH
	U5NZJjWD0+UemiUOTGHS3BI7t4BOnuLm43iyNMntk1ME8tC15jyPlgSg
X-Gm-Gg: AYBFou1V60p2RYVeqVNKXvhKyAJ4oAR0ZqVh0l48uLh0H2dUJAl9PfA/Zp/Zt87hdG/
	ruU/ia4TQ+2QqUh53QED0kkDPmLX9YaCxaMXch+cg1Xor98P5WaydRFNBcBxb/tcw9fndmXHFUv
	D0eQPauIxitDYYlzt1Z6bfMgULJAv0DIgV+flKMAgdteGHzDU9gYcj5pwTdwiZxPULLYxN4ksue
	u+Jgck63UxtExYL3GB+hZx5E2iuRwt3xw/bCXANL5DOHblhYY7A3zvMccrk44ZNyz5UJ3pC8q34
	Vvytk39mGXoyR1MwYoZt9BuDGFcwt+j28UOlxZU8Ghh/xrTnBpXwgZb/oC2iOHiYNpfS70EFFRJ
	n4SuMTOLx1Q0umhpVJW8/QG1k8nzW3z8Tt9Vh4riPQFFJ6EZDO/9x0gebH1WYQb6PaW4qftFcl6
	rXeBiEOfksqrjDatuAPPyn3OcrSOZnwxN7mUB1dpwVXHzst5kedQsMeV6sQf7ltUeNtgOZLH1yh
	N+CrcJXb0kjaSL+vnmiHORZIua4L4U2GnrjsIOpuu4PP4I8EOFmaD1zGdAz3cxhwk0NHAvMQJLt
	1MGjigunEXOSTo3T
X-Received: by 2002:a17:907:72c8:b0:c50:73bd:ed25 with SMTP id a640c23a62f3a-c50964287eemr9546666b.49.1794508420573;
        Thu, 12 Nov 2026 10:33:40 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b40918sm6171366b.39.2026.11.12.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:37 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/13] jump_label: Index text reservation lookups
Message-ID: <avYGgU3bp5KEF0ql@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-3-jolsa@kernel.org>
 <20261112083305.GD2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112083305.GD2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:33:05AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:05PM +0100, Jiri Olsa wrote:
> > Text reservation checks scan every jump entry. Build an index sorted by
> > code address for core entries and use binary search to find the starting
> > point near the requested range. Keep the original table sorted by
> > static-key address for updates.
> > 
> > Module reservation checks continue to use a linear scan, avoiding
> > per-module index allocation and teardown complexity.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This is the *exact* same code as the last patch; seriously? You
> couldn't share?

I think we could share the search for the lower bound,
but then the overlap check is different

perhaps if we keep the index generic we could share the
allocation and setup, I'll check

jirka
