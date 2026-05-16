Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1034B437
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958406; cv=none; b=Jo2LvSbdKaxU0EU8BXAp9a05ScHkOm4EHwrbg2ZFGb0fA0nhqNFiVfGWsryPeLU21UKaOWmR7UclOinhcFo5xVSlk7eKhIkQqYMK9jEvUj76SkAFdq63pJPVV8hBns0ZeG2axLmzemoFcPM0JNg2Qbv8e/nogtxZvanUQnkZkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958406; c=relaxed/simple;
	bh=aOOOxtwS47BU27kjezp+YWuh0no9yiOta0v8lP6p424=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PqYj6nmmYsWbwZgDNerxvqhlYT/f+yG/G4QcHO5pBH5oIke024qX06rstvM7PwSdXKX8mCifX/AXGTjQ9HQ0tax1KbvPMpfFbWBWERLxVQDZtD+4PsULmgnCIRpaWvYbQWv5vLJ1OWt6YfSl22uHNHOhCk9Lbq/+0nhg723I4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Rf1HNgO9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Rf1HNgO9"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbd23bc684so465773a34.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778958404; x=1779563204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qaeOTyQgpMmhTaTkzXZZ6dUGH8G4c8JGdwyT+X2ku9U=;
        b=Rf1HNgO9HXQMVG1OXYTwvQy5HQkJI/cgD5yq6qfSv05nVMQf2RWm/ydTL3fMRYVYaV
         tAlI0Pq84UArCPjDAuf+2FsJtzJpz5WZLJvUOthL0gYguNsYm1BygEtmlg6h5pQ9bOCf
         zpzbXLYP86XOdHgzLgJ16tsSAsnuOJif0xWZ737oO/Cw9DZmaD7k7KrN0dj3fVzh0UI8
         0s9HePkJ2drxmQhiMjeEYCSKw0daD1ivCjOZ0IecVD0v4prAcMAwu10fM/+lN+F4XSjv
         2RTXs0l0i7Yh4PBhxkmtxHSkA6295HVnR3nZZeREdy1tqN+LBCST5VlMHcTebXBL0Adl
         UaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958404; x=1779563204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaeOTyQgpMmhTaTkzXZZ6dUGH8G4c8JGdwyT+X2ku9U=;
        b=NjqaTOWtmzrjEMRAP/Vifaeu63Jb8e7awB2yaZitTPkS7GIZzLThuiWa3D5fZ+Hu9H
         B0Qb3MaHaHKBiqCQT1tUtuy2duQgxq91lkrcgctcYnwRP4267C5m1PDK1x0TbLpOc9y4
         edmoVcJQaRK1oymtNa2x2naDBn8H8iswNsulfKdJVnssndYNICh/bSvSCPxALJBX44jT
         JoNxDMGimRt2rG3R1o9dXrKrcqL/TbVBaqnNhPEziGbsB66BCdLsDmP/RHGQ0Pnms+sn
         0ii61O6nAJaA+kBEPugi5fsBA0w60uc30fONFA0vAHoWmRApoNqTAWr2mPlFz7fIo4SQ
         xU6A==
X-Forwarded-Encrypted: i=1; AFNElJ/G+ibhCVeFUP3l5dWx8c4vyPP4yRSPbiBeX820wP3WyCm+UpX83xLA2rGsz6nE3A9Oq/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpY4WJ78Ww7aG0GnqH5v0tvB569ywYxyPXJWk2JMosCATyNKv
	nvi0MA3vrbzAvH+eFUwxduT76TpE6zhGN0fa0g6bvbI9kavv3Zoa8G7aCOw/eVXYYIEYch5fG5m
	7lj5P
X-Gm-Gg: Acq92OHSo4q9erfgoT7E6nyO0DKFuKdzaFMSw+JAtxr3IUwi6XRV1+bwT7wE9Vxmp2O
	qTm9k9EWesTBqdADvWujHFn2OVKnYFimWU+k61uAoEH29ZD3SS8CukxcdVyRHXWxyk+nVqlC3Po
	/D7BQKy4WPlHVL+quL8lxRttH5DKeAtL9AwubgrI2P7J1lJnkJfhnAdI5jRE+u9e44IsWTNbFsA
	QVkZ9dDauUbPY8bnuehzPiUj2Et7wBVWrMX1EX4sAi/pMZ+rsvrQ/MV9XV+WxiSZq5Hh9s9Gf5N
	0XsBhhTFjGIBZls1TGoddq2a2/PCunuE3RjPz26fSaYJ4VqqoqD3a2E22yQvANTkZKvSO7F5n2K
	hLckWI0IyOYQWRGaLmdYkWeCvzl5F0qHHMvOnPiQgVeve53klHKeNenx9eRHezUqxHc28Oxh63D
	ChiRMLJ3HquiUj7VXKjDGACVnClW7jo2y8vn2AeoCb337CxY39btgtxbIdupRE/zfg/wJzAhCK7
	+jG/xot5NsHyMg6+mv+P6KwvTIuk14=
X-Received: by 2002:a4a:ec43:0:b0:69c:5d2b:4079 with SMTP id 006d021491bc7-69c942a5fcdmr5095624eaf.6.1778958404415;
        Sat, 16 May 2026 12:06:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d046130cbsm3090413eaf.5.2026.05.16.12.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 12:06:43 -0700 (PDT)
Message-ID: <21a2b88f-ec94-46df-b018-8a027689c38e@kernel.dk>
Date: Sat, 16 May 2026 13:06:42 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: propagate array_index_nospec opcode into
 req->opcode
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Michael Bommarito <michael.bommarito@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Li Zetao <lizetao1@huawei.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515145812.1241925-1-michael.bommarito@gmail.com>
 <177895835722.925638.5480075990608035864.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <177895835722.925638.5480075990608035864.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/26 1:05 PM, Jens Axboe wrote:
> 
> On Fri, 15 May 2026 10:58:11 -0400, Michael Bommarito wrote:
>> Commit 1e988c3fe126 ("io_uring: prevent opcode speculation") added
>> array_index_nospec() to the local opcode in io_init_req(), but the
>> sanitised value is not written back to req->opcode.  The
>> unconditional write at the top of io_init_req() stores the raw byte
>> into the persistent field; the success path of the bounds check
>> leaves it unchanged, and downstream consumers read the raw value.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] io_uring: propagate array_index_nospec opcode into req->opcode
>       (no commit info)

Oops, was just applied for review, nothing has been applied. Awaiting
a v2 based on the feedback.

-- 
Jens Axboe

