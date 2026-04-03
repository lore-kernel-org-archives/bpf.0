Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B55230BDB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231197; cv=none; b=UyoHSxSTZZ03yj/6bmOXoRjj4LP0FPBp8Bs3jX4RNLZAxGU/2AK93ucExUp+BnOvIw17LHy6fygqUbNnF++nMsCHqr6cQnbtj+G82j3hks4SNWZvJmS1eotYjZuGUwgRqA3LyIvL4l/FXfSouRyu9Oj6AaASiRhtOVz3MO8Pvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231197; c=relaxed/simple;
	bh=1HwRQZ8lP8jZGh5b/FgAtpH3dI3DnAUhco17qeYKq+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQL5BxGAqjP4hJzxM+n/fTU8N7NhDlf5CqJVAAMFRT3DlU9KH5h3IeNzZ8mxsBqk9FMR9qwgd4cFAE/zAhjx3jvthM+qkajWeT9AGGLyCzdDqCyzybP5iAcn16f5V0N8fKxrYyzqEV8adniPgTdI881DNJmoeZED9AqH0bzYPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=F0i5eEjQ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="F0i5eEjQ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d1872504cbso1926309a34.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775231195; x=1775835995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0c0DhKW2IhtOv8mkjVWIMAgeS4UtF/c2tQs3JYMSlA=;
        b=F0i5eEjQLDzkNLh2xU5B1l+7cdqvLO/gaTxruFIO+bwxcslVc5friyGaZhghre0fo+
         Y8UaIIAnO9Wc/iSGhhoYGuzxjMCzX6qZD2/SA3322EU3ojqjP9oos5Ya3zcnyTAuavm7
         7NZCiLibeDM+NVrLQ+2zo7UWMrA22OQCP7o/dfNb/YkgJh8YXF4hp/J2hgz3Z4yF51pv
         tutWvulLOaHXBSqKI2rX+6PA1glGT43B+1p7ejpbuugYUelzCyE+n5k0eolHr1HGV0dk
         3jwQF6vRwGpe+NyCpt1Hf9XGqAunc2oxtNoKJZJ6x6/lN1lNd6DBwNn0GfH8AWTcPre2
         tY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231195; x=1775835995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0c0DhKW2IhtOv8mkjVWIMAgeS4UtF/c2tQs3JYMSlA=;
        b=flmPZWc9FsXrxFzrFTynDOpk49U9glJFSPpe+/ACjWCwxPPZ2oxX+w4gBqK/Z2CqTK
         V97EiwagkMt+kFWWvbWMBlOfDBKIEJ+7sgGm1MXGpRmWc2+djQlW4RJ7ADdsAFLwWlhH
         KxtTpmq7k7pLFsqwSLUrOqeMG2VTm5e3K1/Sjg27QSg6ekjmxe8L3w/PPCXn7t0H8rsA
         y+HuSOE/WCS5AyGFHkJl6RVg9OVLbL8GfIxNqoaaUNszLMb253KEiRTC0BX9Ro/MXPKd
         bwe9iUF+FgqPz/apdA2BPT7Qk9E06C1Oy5hRHzWLXPTcDoUhN1bNrSm5eP4YpZ4N35cz
         kMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWynTvT6iSM5OrRXPRTaqwd6ApoNzlH3DLaYRLl+B+RF5Xdz4rKHKufV9qxfqK13rh2zOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY90Nfw6qhUwPOlQtnzmRYzQVm5Ko7zIcxNT4a7lYY/7p5N/MH
	uEm9pBTAzzwP/HlnVwkSVvN9zC4KK19xJ7FS2jE/OIHRXS/LwT3aHM9/7TSW0NIm9Nw=
X-Gm-Gg: ATEYQzx04wWkdk1urgvzfYVdz0JDyg8/NFbudZJ8NMUTxVTa4bVjzgPWx80WojkqDML
	O53U/XnN5ZTFG8Ow8JDsVHAIr8Herb54XtsF1UBZ0MG2Ko5cKsVJ1j/Lpq4zQTlBOTi+84AbPN1
	ELROp+yC4Ix0dwyDX8bdDec24xVUKtJXM2GJvWzX4evqiPXlYdCYPfdDYF5yxxRzK5L9akFYqzK
	GryDRRjPy2JEeTcBnLkob/Fp6QT6ZDcROnqjoTjq/YTUCD19cSv5WSiX3LlYZYxQHwipliShnVQ
	+cZH4cnLdNafNY/PgSIN8r1LxWlNq+CqCAoRppU2ahy06xwhzesR/CfgUcVKznYuc4KLvsZTc4L
	HBdbjYRoySS+I+oDZacajMQDSCJQkE0WgF4JzkhM8cYIhKkcEh4GzBSbcPOvu6y8FE+CY7leGtm
	QnaBK5ZXr/UDqyhoPr+kNRjueskAF4e5OInU4oVgyV6am2IB/wjB0tFfXJ8n3nADwZXDCKUFnDp
	FzHWY+v
X-Received: by 2002:a05:6830:65c5:10b0:7db:9910:de8d with SMTP id 46e09a7af769-7dbabc2ee95mr2629346a34.7.1775231191605;
        Fri, 03 Apr 2026 08:46:31 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7126f1bsm4609233a34.4.2026.04.03.08.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 08:46:30 -0700 (PDT)
Message-ID: <cb3e52fc-3dad-4385-b9b7-ade9add5292f@kernel.dk>
Date: Fri, 3 Apr 2026 09:46:29 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/12] io_uring: bpf: extend io_uring with bpf
 struct_ops
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Xiao Ni <xni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
 <20260324163753.1900977-6-ming.lei@redhat.com>
 <b7216cd5-68f4-4ab5-b1c8-b1c71f38fc00@kernel.dk> <ac8_XZZiTmHi3mwq@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ac8_XZZiTmHi3mwq@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/26 10:17 PM, Ming Lei wrote:
> On Wed, Mar 25, 2026 at 08:09:03PM -0600, Jens Axboe wrote:
>> On 3/24/26 10:37 AM, Ming Lei wrote:
>>>  int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>>  {
>>> +	struct uring_bpf_data *data = io_kiocb_to_cmd(req, struct uring_bpf_data);
>>> +	u32 opf = READ_ONCE(sqe->bpf_op_flags);
>>> +	unsigned char bpf_op = uring_bpf_get_op(opf);
>>> +	const struct uring_bpf_ops *ops;
>>> +
>>> +	if (unlikely(!(req->ctx->flags & IORING_SETUP_BPF_EXT)))
>>> +		goto fail;
>>> +
>>> +	if (bpf_op >= IO_RING_MAX_BPF_OPS)
>>> +		return -EINVAL;
>>> +
>>> +	ops = req->ctx->bpf_ext_ops[bpf_op].ops;
>>> +	data->opf = opf;
>>> +	data->ops = ops;
>>> +	if (ops && ops->prep_fn)
>>> +		return ops->prep_fn(data, sqe);
>>> +fail:
>>>  	return -EOPNOTSUPP;
>>>  }
>>
>> Any early exit should ensure 'data' is sane, so that the cleanup doesn't
>> potentially touch uninitialized crap. This is something that has bit us
>> in the past. Not an issue for this patch that adds the code, but it will
>> be once the next patch is applied. Better to clear ->opf/ops here
>> upfront, so that we never leave this function without 'data' being fully
>> initialized.
> 
> But ->cleanup() is only called in case of REQ_F_NEED_CLEANUP.
> 
> Or maybe you mean other cleanup instead of ->cleanup()?

I do mean ->cleanup() - what I'm trying to say here is that we've had
cases of REQ_F_NEED_CLEANUP being set late, and hence missing cleanup
for easily hit error conditions, and non-initialized data being exposed
in cleanup. It's very easy to miss for later patches that adds another
error condition. My recommendation is to fully initialize 'data' and set
REQ_F_NEED_CLEANUP early, which handily avoids that for future changes
too.

-- 
Jens Axboe
