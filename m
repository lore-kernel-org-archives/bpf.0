Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974F2EEE84
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046102; cv=none; b=JXcSCt2qMcxG12YJ8X5iUqNPr1VCgl1VWuxxd9S+thZD0rn+LB5raf1IIaK4oTAl0slKXrpohNF4Y54FkFAMRMWYxFYjO6/Xcwkhkdybs24dBk53jPGZuaUtH2mrOD2gw1QTDfW5mNPyrQ19xinkrHJrCedwEVDH7n8UHQ4J4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046102; c=relaxed/simple;
	bh=mrZFcael0i2SHdBnYzZgJ135z3Sm7u+UibmRrm3Y01k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=MM6l6qfePfZ/1pDQqQFYYYO378ZScOTcWdLy76FzzVZIRnOIiP4tmCLZ12oteqtlH5NLEq/CY+6++MiGb0+piccXHW2gMmE+hISas/GxnWyPwppMAKRbsveW3pmED0X8H/YU+SLKmJ+9XIaO3m81I+17j27boSgSEeaxYCT1VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtWsABcZ; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtWsABcZ"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2d747ec6185so22780695ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046100; x=1790650900; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VToeL6vAbXQdg6OORL5InxeCdnH1MZA2FYzoAYymOug=;
        b=YtWsABcZSpNnN2q6gpz6tEpag5/LNOnoLq7rEPoV2XDYINApD0EATz2MPjtYszGjQ0
         Hxg0Mkp5c7NsBN0HYby3sHzbmqV3n7MxkuoNasWHKKWjKromKShNYXeOrpjvfZgNHMGB
         iriQM6a1q0p210evTU/cdQG3NWuJtIG4yjKkmLRLVE37gpW4rLlskZ784IcEX3cNO+tS
         QPMPoWPRcFcqP5e6axKjn63kgUE7ERRkC2INQCXilb2Bcq2TyvAj9Hj7yZfkv/2FiFi9
         Wb1/eRRvIkQppVhxf9Y+R4m6rqcBoGj0SWhk5yTh1cb0EYnzq1QfrF0hfCI8TJEPuUOw
         QOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046100; x=1790650900;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VToeL6vAbXQdg6OORL5InxeCdnH1MZA2FYzoAYymOug=;
        b=0C84UbKbcFD/eM+WPn1hOURe99ZwZoR/KgUKCg3gN0gQdP4AF3Jn37EGFaneqfcbFL
         hiW8Tc+eB25KDGyjFRtzNCgF/aVlu+B3Pgzz7SI1b2wxFYM15cYWjryyYTsTvXVTZU/M
         MfVQyfx2xzlT1ZI21ODKsjQAkADrCZ5c1TwfHDCmUS7yJoVQrrMv3zlZMzb6O0+ap8A9
         feJAY2HGhWRdOE334QV8oyLmx/nwoJf3A9rVftJjtvv7W7RE1zmfBbLaKSQ//335XnQp
         4bclUEdAGW4fU3eNu5SinatDlo6IirNXaNIll6SmX69sgdfFnqMkySMmh7JweAHsp4KE
         8TQA==
X-Gm-Message-State: AFuF++ng3WPNgvn9F/Hq1ADzHYZl1JuvbYECz/zRoaWz+FRPjK72YHxX
	DvV0HOpsetcr7Yo+/cBHZr3lcYwvisZ6QYgq5g78RYeUwYfRLylou1uK
X-Gm-Gg: AYBFou2pYFCppZOAfXxvBXjO3IxekmovtwNAlrdknpWTU+PvD7aUWzaBA0cvn1bD0jC
	EtGf+K8lC+VhG+NS5RME0xiJxBb8SnzZdEc4qZlt9PFSRhnIzjv6+bxWV8H1snz+nLnuRz64QJA
	2nbXUrKQ2YzdRYFxYkfs0fviyxbHQmtqjXjLhAku5qTw0FegoYaMkLj1snUiwQt5yQWDcXgBp81
	FlYaUCT7Sn3g76Eho9dplvCTqNCLqfrrm5zqVwAwpKYWzoza1zLW3f/cdFdl3MAR2VFzduArxfu
	H02GZ/xv2Rul768O3rgQiYfTCZukH8pJmNnpNuEmLA1lcJB/u7ApGumlwynY4OiT0lKkZnab/xw
	LnVtZjYqdTV8t1awGXwZDb4Tz+POwj59QQxClXasLZOz2IZAxnjhQX2N3lA6BENLoUGI+Qwr0L3
	33jBoZtn/W9fUVrT5F1ahAteMVsczQa7orkHCYJdTtj1+h0jhPLESCPDh1CYzQRJiyUSBylabQB
	cbTMJkkHA31he/0y9tZT5VM6RfUXgWEqIBaPv/PN7Wsje2jMjySPOfz9sYG1wHci2qpG9kTfUjs
	eWc=
X-Received: by 2002:a17:90b:2b8c:b0:39e:b7:cbea with SMTP id 98e67ed59e1d1-39e54e3d37fmr17962423a91.18.1790046099700;
        Mon, 21 Sep 2026 20:01:39 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e570d9esm549993a91.10.2026.09.21.20.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 20:01:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 03:01:39 +0000
Message-Id: <DLLIDTH3V5WR.3M19UWMDAHFMQ@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 10/17] bpf: Recognize pointers to functions in
 read-only maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
In-Reply-To: <20260922013100.6DF101F000FF@smtp.kernel.org>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com> <20260922011323.1298619-11-alexei.starovoitov@gmail.com> <20260922013100.6DF101F000FF@smtp.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 01:31 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		/*
>> +		 * The program that didn't load is not a user of the map. libbpf
>> +		 * loads the program again to get the log of the verifier.
>> +		 */
>> +		cmpxchg(&map->user, (unsigned long)aux, 0);
>
> [Severity: Medium]
> Will this properly clear the map's user state if the BPF_MAP_USER_PATCHED
> flag was set before a failure?
>
> If jit_subprogs() sets the BPF_MAP_USER_PATCHED flag, map->user becomes
> me | BPF_MAP_USER_PATCHED. If a failure happens afterward, this cmpxchg()
> strictly expects map->user to equal aux, which will fail to match.
>
> This can leave the map permanently locked in the patched state, causing
> libbpf's subsequent reload attempt (to obtain the verifier log) to fail
> with -EBUSY.

No. Not a bug.

>> +		} else if (verifier_bug_if(ptr->used, env, "function of map '%s' offset %u is removed",
>> +					   ptr->map->name, ptr->map_off)) {
>
> [Severity: High]
> Does eagerly setting ptr->used = true in check_func_ptr_read() lead to a
> verifier bug here if the function is never actually called?
>
> If a program simply reads the function pointer from the map but does not
> invoke callx, check_func_ptr_read() still flags it as used. Since the
> subprogram is never called, dead-code elimination can remove it.
>
> When jit_subprogs() later evaluates the deleted but "used" pointer, it
> incorrectly triggers a WARN_ONCE and returns -EFAULT, rejecting a valid
> program.

hmm. A prog can read the pointer and never call the
function, e.g. when the load is hoisted above a branch. Then the
function is dead, 'used' is set and jit_subprogs() hits
verifier_bug_if().
Will follow up with one line fix.
