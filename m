Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794747320;
	b=ymBqs8EbIt3yN4rglAenWlvNqv3rmHbojq+ORn6VAfIv64fy6ugAWSON/NtmEPZbrNDV
	 olA1eLQJ9ZyOLwMDz2VewVm/XL+GwbuF1mLXvghKTCLd65Q1hzy/VMwWGALLzEd4l7sc2
	 rUw2T+xaR73q8fubEbfoszSsFeZ3SbEK7FzhQRmtsGI6B3HWn8Knf/HjFFkYYDernrHsE
	 GJOT8U7XgyjLBAQrlXaKCEliLuHI0iisIcYr/R1mbvdSRVAfLUxldcRRL3VX1j4asdWkk
	 KmPqAi40hbP1QXEhxb0u+k5wmnHFqAoNHX6XbidRujApQtejb7KXNbCwzrgot2dxzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pajT9ZmF+7X7XRmyjjcRw+TQKM4oC5+LDbTB12MEBUE=;
	b=I5P5TAO/txIb43TfTvyKyOIDnaZz42jCLNbDf3vji+vhsAhN+qCbr3z/9HEEXKju4f15
	 L+2DEBpEXSU/8KQmwKbHbGTsa2YmoAkcXQAqbiPvTzHcYBw+4WGWIjLnnz+H6ErMUalDK
	 RPapisKK+BYML4fr2BESIQZwVwpL15RLS4g0Cy6siS3cGTOBUSM26npDMFacdfgRaLlSW
	 gd978m0wVQI00bzd7fLOoYL+eTP/vqDaBf+sDFAcvvpBzPa9kCBLDTiyGSRaWWQSn3jgm
	 r6FgWBJclXUNRbBztrekVkqvXHHFnvCY7XZKDdSiIEwZPnn/mpSGM2ChPby0QlC/eyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6wmtnOe;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAE606A31A
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 12:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CEAE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6wmtnOe
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4918c2d727fso1303605f8f.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 04:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794747319; x=1795352119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pajT9ZmF+7X7XRmyjjcRw+TQKM4oC5+LDbTB12MEBUE=;
        b=k6wmtnOeFKLk+AOaiwZ503dA30511YdMipDyRN8aDY6mM+Q5oaVsghNmFiapiOWeum
         trk1wJhflM0a+aFfRHIFMmQ6ygMMa4Yn3+RKbEIQ5cq7GOqO7JECU4MmiJlHiUwG3FCZ
         L5w+E8LRyNJhK6UJ1l3ZltRGeH5WYhUZU23qHDBpwl7DbkGA+3IgVhdhe3S8UOXhVGlw
         j3bhNrC7CCwLfpkd0dXF32uXHnuOkTIxdkoSwSEyeaoitF2Zaq22D1KzojZNuTEw2c4V
         AgUKgK6IKfmluCul6/NdG5BxoWrW/rOp8a85/dC6VjarU6NwJYasg4JwaYz5im80XR/H
         F7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794747319; x=1795352119;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pajT9ZmF+7X7XRmyjjcRw+TQKM4oC5+LDbTB12MEBUE=;
        b=QdPrLM0F0mc+PQC+A+cnKsuH2aMEqJHp7N9vFaX0BTI246cvyh40+JEYCuqNb93rU4
         CGe/6HG7VWT8FAcMKizw9RKdRAsi6Nh2kNay6p3d/AkVddi6afqJUW1EpxJMeuqIGC7E
         uVuIYR3KeW0ycGB0CP8aHaHL7+yJTbKCX/QIwU4N/UpeLPEla0MQ6fk7kgtpFVG2dZg7
         fQG4hmgXZWw807YydYImlXPsW/KURFUS/7CZbTVlJuQeKguhD4CGp1Rx2E5+DrR3BOx0
         Fz341pnuLS4XHePZBgsDgommnncZ/A2S+EaMPDaVX7i+D9IJkzYvnKujMSIKfAu4Adru
         Ywfg==
X-Forwarded-Encrypted: i=1; AL+hErFrYXl2rNbuVe3YuyuGA1GrgppLz+mFrVZW+JTBecNwnGjgqn78h4F7SZC6xYXKKYL6qdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vmTrINh20qcUV1CcAEAfwy4pgG6jJLTwv4bT90fS935/i0KrO
	JPD+DjQ5VJQyh8VZRK87/NlzOdfDkSSBwPaY6up5GkkaJZcj3jHte3EY
X-Gm-Gg: AYBFou2DxNURoL6OF9WpmMn0VqrzJFCwiCMIbRh/VV9XyejflKUmktkKhlv0SgC8N9V
	bK76Hca9/Fz7kdYO9CSOXfhYnekzIuVEkQqwO6XgSlVazlYbTM3NmdWmsn8DLUaqy9HxdWBGzah
	w8oGz1dk1Kfz4AFlHZxmopasB7txKd44J6HIESlvlyv447bn6EusfhKw4FnUpkDeOpwwoIm6Wte
	OFlVdjsPOhPocslnJ10vjeFVZIsyespAD71JWXBqS7yiyJ2xLeAfbkThBh1adjn2J3TIlyL3EJv
	1ca3IItXrHPfW+ZglAy8wE+TOCvzgxvhX0BGWvrOWMJjZZzjcXmQXHNZpwMwx4Jg+rlR3+RPtzb
	fSOkdbZVYU4JQQmbdbkBK2gemPlGrKGNVrpbZlnrWHJja1HL6LhAoaMmpLgG0oM7ceN2OUVsddC
	+0KTZDSkHbpjRuojt5xdkyekxBmcHbmQtcYryZXUApch+hEAFmQIRP4a7FHS8TijxiHD+YdaZa0
	BB8kJA/zAr9PfcsVumBRHSRUvJPOluuuYM2dYm4E9eLwaenhvCaGQZTzsFXyJHBb3dY5K78whsC
	yX8WVfTobobqgNZnT4KghT4G/4Q3Bu47iAv392Opd3nHqdU40p0Zlt9oDezgKBFxBneI6rfMNRc
	Fqm9YBnmDzi4=
X-Received: by 2002:a05:6000:26c9:b0:493:32cf:ff9a with SMTP id ffacd0b85a97d-49c7325c195mr18243724f8f.56.1794747318559;
        Sun, 15 Nov 2026 04:55:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d03b104sm16969858f8f.6.2026.11.15.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 04:55:18 -0800 (PST)
Date: Sun, 15 Nov 2026 12:55:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: pmladek@suse.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, jim.cromie@gmail.com,
 ljs@kernel.org, mcgrof@kernel.org, andrey.grodzovsky@crowdstrike.com,
 rostedt@goodmis.org, andrii@kernel.org, wusamuel@google.com,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 next 06/13] kallsyms: Improve selftest
 test_perf_kallsyms_lookup_name() output
Message-ID: <20261115125517.362eeb4a@pumpkin>
In-Reply-To: <54d7eddad4b50bbaa72bc31ea3219ce9a944548da1fef3eabbc1e7337d37e5f2@mail.kernel.org>
References: <20261111115911.1142000-7-david.laight.linux@gmail.com>
	<54d7eddad4b50bbaa72bc31ea3219ce9a944548da1fef3eabbc1e7337d37e5f2@mail.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 23:17:06 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output  
> 
> TL;DR: Commit message only: it says 4 functions get noinline_for_stack but the
> patch marks 5, and it omits the compression-ratio output format fix; maybe
> split that into a separate patch.
> 
> > kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
> >
> > - Improve the test stability/reproducability by taking the faster of
> >   two calls to kallsyms_lookup_name().
> > - Check that kallsyms_lookup_name() returns the expected address
> >   unless the symbol is duplicated.
> > - Report the names of the min/max symbols.
> > - Output an 8 line 64 entry histogram of the times taken.
> > - This shows there is a reasonably normal distribution with a small
> >   number of much slower outliers that don't really affect the average.
> >
> > Additionally:
> > - Add a very long symbol to check the handling of two byte lengths.
> > - Do the test_perf_kallsyms_lookup_name() last because it can take long
> >   enough that the CPU frequency changes and the times reported by the
> >   other tests can change.
> > - Mark the 4 test functions noinline_for_stack since they all have a
> >   quite large on-stack structure.
> >
> > Example output (after all these patches)
> > kallsyms_on_each_symbol() traverse all: 7742950 ns
> > kallsyms_on_each_match_symbol() traverse all: 951 ns
> > kallsyms_lookup_name() looked up 123312 symbols, average 200 ns
> >         fastest 60 ns (_rs.0)
> >         slowest 662 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
> >         Distribution, 20ns per column, 2916 counts per *:
> >         |         **
> >         |        ****
> >         |        ****
> >         |        ****
> >         |       ******
> >         |       *******
> >         |      *********
> >         |   ******************  **    * * *
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> >  
> 
> The changelog says 4 test functions are marked noinline_for_stack "since they
> all have a quite large on-stack structure", but the patch marks five:
> test_kallsyms_compression_ratio(), test_perf_kallsyms_lookup_name(),
> test_perf_kallsyms_on_each_symbol(), test_perf_kallsyms_on_each_match_symbol()
> and test_kallsyms_basic_function().
> 
> test_kallsyms_compression_ratio() has only seven u32 locals and no large
> on-stack structure, so the stated reason does not cover it.

The large stack frame is hidden, it is inside kallsyms_on_each_symbol().
So the commit message should probably just say 'all'.

> 
> The same function also changes its output format from "%2d.%-2d" to
> "%2d.%02d", which fixes how the fractional part is printed (12.05 used to show
> as "12.5 "). The changelog does not mention this.

I mentioned in it the changes for v3 lower down.

David

> Could the changelog give the right count and mention the format fix, or should
> the compression-ratio changes go in a separate patch?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394

