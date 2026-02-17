Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81154361DA5
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334045; cv=none; b=b7WJAs6oWSqxoFtudoA9yXTSvbVCOBJEyYNaHDJJgWXO0hY/rE7EP/pvyuRIMZOfXyUM6EmxD0vEVzmv2YKq9QyeowzTKS8u9pC4996xYkxqgBEH77eLbSf86z+OP6yMQj6rCur53Qvs/4s7j62rgQTOw2/DzFfofYrkeCg0iLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334045; c=relaxed/simple;
	bh=KgdImVWaXCqHS7IFf+UtC6bOQ8fO+oFr0mCM3o/JL3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQA8FPfRqRICHkQeRTIoM+L/L1WiwK5irdRI58dCKHDRW8cy+KTwufsx8VqaHOnRkSSDIzZSU2ZwCQUikj4diprHMRCUrWMcXifFST5EXB/23gpxoTsMn8KXkifb8eCZx2lXwCY3LOdYlPXpQVQBHNK9d6TTp+YJSz8TjrqneBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ACfDFMUP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ACfDFMUP"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40fb2789476so1537698fac.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771334042; x=1771938842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hvRTCg0bG7pjf0n0vlP3LHvxQEYZFAerxPCqp6C9Yg=;
        b=ACfDFMUPMD77feB/ZsadPSA0wGjNWW8fvFsI1wpraQeGV/OrnLZQ3Hx6QmnpTGDiyG
         gnmC/nK3PipMfi5AlBXmbbgossQTnpiDz6I7vc9fGU3xAdeO4vfP2VdG0QXzknlqZDuN
         a5L8ayh0Tfobpoczrywejn9StIX5ziSt9MohUKSMfXxAphOv6S9Ohw8bFbi92zMvZCzq
         NN4hm1mL9+3RekbdMVHENocinQIIN+mt03sKBoXsWPR8CIxXSiK5JQ8uYAkWLyblD07p
         8U2xYdoo9Krxmzeyn7uOMUiflhonBrumrTWhs7P0YDzKo01atd2VuBSFHzbVfVT2jQHy
         hmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334042; x=1771938842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hvRTCg0bG7pjf0n0vlP3LHvxQEYZFAerxPCqp6C9Yg=;
        b=M+k6WrKnxw8iVRH8uUcoUQ3Z1/OZPORG4yjLT0z7ZhQWZLOHtIzgZJ0sq45Mn6SaqY
         VyytU5H1QS9iF0fuCv9xREg3Fis3yV9Tuexa5KVrPllnVXvs+OVR5ji0NbAC8VgYSISe
         A55cV+LJ7an4YBLZnR4xZ4UXP62KqgfqiPoAGuomN4zLrkd/0w9wOJ7Rk5ydVVY9V6dL
         5Qp+w5T2geLOf3YJg1UttbKKtP7FXfArn5srshr/cMIHwcXBYDTz3y60jRwLC4DDNcO3
         SpBjRIscnTp5GfKXy6Yf3XdwoxQ0+6Q3V+NnTiLsvltAMqEm1oO70XojmYx0g6z3/ZXo
         ATDg==
X-Gm-Message-State: AOJu0YytrhvXBos9MJSKqpGOshll2oQOPUpRNMjK3WCDXf3brZMfcFEE
	XhW9LzTYubjSCF70gDjZAm4DrAqctGnDDlzBhvQA1RaIHV4MJ+5eE8aVRQODWKt97GQ=
X-Gm-Gg: AZuq6aKpOOm14RBdePX8076TxDryKkicPOvrfA3xFge4GDtgldL3FfNyIVr1x3bpiMm
	XgVuCindIKRAGzFMy8fEq8+NBsBoMmNqxUJiMmdf2GNIHr6KbkMcFRAGysZasOynY8d43IWmfN9
	0P+0OttwQ4YslfTj9IXPcnRQOlKjP7dO3JXQX4jFM0JeJZx5FGcw0eKucdXn5v0IKkbn05jIAT6
	gopiJewy2FgwAGsaQX8QcfYUDebVGihfgZI8SfJWsYd2nDBq8xUe2zZyl2OsxIigPdJ0ZPChUNT
	GivM4SvQBCI9PArSRQz2s/Ot8heGPPxRUNlEfxm9EqbkJlwSICXQtVeY228o2K9LQSa4mYf3826
	7necK0BHg52N3leYCX8NSC1HHwOXjFxW1FYWfZUjlDKd64IL1cioZU/2+pGoLbAL6qEMgNZO59x
	6wPFF3VwJXqlbvOgVtV8HerOg/BIAt9K1n99APUaX85poykGVSscrwWLkR/c4BDhMpQ7ZHgnm8z
	aqVDeoP+Q==
X-Received: by 2002:a05:6870:a103:b0:409:5e6d:2716 with SMTP id 586e51a60fabf-40f0871a263mr6446066fac.5.1771334042340;
        Tue, 17 Feb 2026 05:14:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf103ac3sm17272166fac.11.2026.02.17.05.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:14:01 -0800 (PST)
Message-ID: <de0e155e-05c3-4e6e-9de4-067ac94c01cf@kernel.dk>
Date: Tue, 17 Feb 2026 06:14:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v6 0/5] BPF controlled io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
 <d56b5f70-382e-4017-81f4-c9ae7a6c1b56@gmail.com>
 <ab4c6ffd-d7d2-45fc-bbd5-b6663d5c41e2@kernel.dk>
 <1985145e-7181-40c6-821d-239f62410618@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1985145e-7181-40c6-821d-239f62410618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/26 4:29 AM, Pavel Begunkov wrote:
> On 2/16/26 15:18, Jens Axboe wrote:
>> On 2/16/26 7:23 AM, Pavel Begunkov wrote:
>>> On 2/11/26 19:04, Pavel Begunkov wrote:
>>>> This series introduces a way to override the standard io_uring_enter
>>>> syscall execution with an extendible event loop, which can be controlled
>>>> by BPF via new io_uring struct_ops or from within the kernel.
>>>
>>> Let me know if there are any concerns or comments. There are some
>>> parts that I'll need to add like timeouts for waiting, but those
>>> will be natural extensions, and this feels like a good base to
>>> move forward in general.
>>
>> I don't have any complaints on it, but would be good to hear from the
>> BPF folks.
> 
> I assumed Alexei has nothing against it in general since he didn't
> mention, and his last review was quite straightforward, I just applied
> all changes. But I'm not sure if he wants to take a another look.
> 
> I'll send out v8 to silence smatch, and let's see if BPF folks have
> time for it.

Let's plan on queueing it up once the 7.1 branches are started. In the
mean time, can we have some liburing side test / examples so people can
play with it and understand how to use it?

-- 
Jens Axboe
