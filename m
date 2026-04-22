Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78439D6E1
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894378; cv=none; b=LOT3GD5HOqcIEAY52pjrOikOrQ0BMLVbbYC49uxy71Ij3qm1xoV4MFqW8/aMRvZxXKPJfRuyS9u1YHi5ixvXTy73vS/842uW7InYsfQBpx05n8kmJbvHciI9M2MYccvmeHfpxgOMPnSW5P6Mh0oRlmItQD61N7NC5mGPXUAgDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894378; c=relaxed/simple;
	bh=mDI7Vjyn+MmdI5Ki7u3cVQG4QQJJEz7okKKV7f5Zjl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOiDqVh7UdKXumclGx7gf6eg1YaDwnpr9I1ag1ryR7vjq9kPTw3V+TMOHUwAEARa0luSKi1n5K38/rUUngGz1bNirPXtzO9CvXgYFk/4xikHEFXib4FC4pSu/H827PitR7EjvS64MK/sDjrmzTsxHSKgK9jsYV+mL4nZsjPWyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=yTdPxSJw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="yTdPxSJw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4be94eeacso5982192a34.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776894376; x=1777499176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juHtPyL8wYmJtBKQBCsxkudJRJvHy1FTueInpPwYCfI=;
        b=yTdPxSJwfc0thXGvISfLvg5UOpUh9E00tyywV4euqJeB0D2yVKqfP0cTLnN38X8uh9
         c+H78yugiGkehh02pwKzuvwjBM1emXAz49HCuVPeoimx5eZVnn9wBWnN4q+ye1Htbhyp
         lwL1YcPjHkFULJU8ypE11P2uhOySDEo/6MfgELOrcs5muZaCtFmNYzCDZvCekhQyXi7S
         DBx1JUAnnX5/6YhiqYZpp/yO36Uja3AR0Hs6kTTiURGXYEnc5IdKbdVrPFE4LXSIf5dL
         yKpUfcjDzVYRn6NOBz4YgRPKXIetramsecsb9wrr9wpgP+QKuZThz5rLIkBmbmHfpV1A
         s0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894376; x=1777499176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juHtPyL8wYmJtBKQBCsxkudJRJvHy1FTueInpPwYCfI=;
        b=a3ev4BpN2VmdAXp6NWVP7Btxc6PjDs6ZPjd9H7xBMH8bT/oxadfZRoQtx9A3iensX5
         6u/wSlFHoMFOHOuliG+JC+MXi9Je/1pNhsMvYTS6mQT5F/oLf8z1J58A18ZEvr4jWh20
         oYgeM8gfxrZ3n33CkmKm3ota74C19BZpVA0icsdQPMs7s9sLV5Tx5V04220YWdHKnjKU
         GfsLCgHR/Cn7xD+HgzFK/FjDk4V6YbJ3S2cFirWrelYImqACp58twiZAiy2oLjvUrRVX
         ohl+n1mdV3GCuh6vAv53m5DvOgFCcXoYmPDDsCGpZA/ALPmh00p4e8NOI63rHRigW/bU
         PK9w==
X-Forwarded-Encrypted: i=1; AFNElJ/9j3ED4CJG9b+ZZfx6pYgmv2duvCjgh8BW3TQO9pc+yhUYtl8fADp+u/jrxa3Jm21/YkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVeWatuu8tlViWO9JyVxqN7YFslDMhzzixhKfXuG59lcP5b9y
	pQzipXM5OnWIfOb1FgY5SdZ/B49XPGOW9Ywv5ELENkIiaga+snJU6HPShofrM2XSinE=
X-Gm-Gg: AeBDiev9tRyeO+oJQkUjdYvDJ8uVCgB1tkjreS43C3vNE+62lJszb9QaFUNF8K7DajF
	4SdRHYM1zlj4RVVxT8Y8lLUNTL34QE/a6k0B/AWxa/iYfdV70MtDJDJwmHAIsikoWZrng0JNcCw
	TglTl1rWxRQZ6vVVjsMmxn0buiYY9dH/hMmYeygWfSv+eg1VUGkPvc87lZw/SvvPcuKpekCZ16M
	bI5SU2+du93LLGA3PCt2qexYPnaZYF1WKXIE6ziidKMeess0AKlhlPiRmghfdfcj9FVcoAaNWSV
	C75HUeMmOoCJEr6CgOjdyCAXguX80EvSoJmwNnuJx0AQEBXPa2BLnhut3GtEYz6WT8zE5lJOn4J
	1jdd5qXBDMnskv6px8JiBgfLptNXS/CwJX/ODxzeLTytrxQ5fswXsVvcQjPrVR6rl1x4tjaifjQ
	zyOEviewHy7Bvn+yUw923JaoTSf9sZGnuJOLZxep6T493RAIPRVYUTczWtdS8+M8RhLomJW8686
	JbjrfT+HigsAST3iug=
X-Received: by 2002:a05:6830:dc7:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7dc951c7513mr14266727a34.17.1776894375664;
        Wed, 22 Apr 2026 14:46:15 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b057bsm16345408a34.20.2026.04.22.14.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 14:46:14 -0700 (PDT)
Message-ID: <3296879f-4650-47f0-9186-f5482a598239@kernel.dk>
Date: Wed, 22 Apr 2026 15:46:13 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix missing submitter_task ownership check in
 bpf_io_reg()
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Ali Raza <elirazamumtaz@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
References: <20260422-master-v1-1-e82f47558345@gmail.com>
 <87eck6ofo8.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87eck6ofo8.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 3:20 PM, Gabriel Krisman Bertazi wrote:
> Ali Raza <elirazamumtaz@gmail.com> writes:
> 
>> bpf_io_reg() installs a BPF struct_ops loop_step on any io_uring ring
>> the caller holds a file descriptor for.  io_uring_ctx_get_file() only
>> validates that the fd resolves to an io_uring file; it does not verify
>> the caller has authority over the ring's submitter_task.
>>
>> A parallel path in io_uring_register() already enforces this:
>>
>>     if (ctx->submitter_task && ctx->submitter_task != current)
>>         return -EEXIST;  /* register.c:733 */
> 
> How is this a protection?  I thought ctx->submitter_task is about
> IORING_SETUP_SINGLE_ISSUER. there is no permission or capability over
> it against other processes.
> 
>> Without the equivalent check in bpf_io_reg(), a local user with
>> CAP_PERFMON can exploit IORING_SETUP_R_DISABLED -- which defers
> 
> I'd argue this is a non-issue.  If you have CAP_PERFMON, you are able to
> mess with the process in many ways beyond this.  Otherwise, how a
> process would be able to get the fd in the first place?

It is a non-issue. It relies entirely on an unrealistic scenarior. Yes
if you have a privileged task that can take over a non-privileged ring
fd, yes than you can do bad things. News at 11...

-- 
Jens Axboe
