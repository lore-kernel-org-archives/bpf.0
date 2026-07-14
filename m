Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C341B8C9
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057135; cv=none; b=d00e3s0CMbd0DHL9RLNZS2o3FOs73yVS6Er3qrFcxpvtAJH7pFG9hhBtRCyqMSSYtpnMB3D+weu3m7GdYB7CxElnOlWGWZcb9Q9TpwbLDcvZKr3+XZw62cgR2zEEFZ3LvKNOxEcQw4W+yR6r2rtJ8H4gF5gUU8jqY+lwjYTtNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057135; c=relaxed/simple;
	bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ3Kl3Zjs4OwQBAYoSS7UfJ286zTtryi6Xu356Bl8JaPnbpp34f+SVu+nYdV6GrKAPafVUcDfdNZOq3JurIfGT81W4pCO5bQ2DccCIbSkZNdt2Nm8/eQ9uBvp3MMIV2fdACIsyhRf/LFVANBAN5FBvevI8yif53ir9tUem8pOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okDiCOV+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okDiCOV+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so1128997b3a.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784057133; x=1784661933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
        b=okDiCOV+3P92TI+p1rRGPjtaWibaZlYz9en4uzovrh1JEHTwvrf8wKV8pcBnhyWejB
         cCYdDKiZ9qC1SEDVf2bsj7PwupV+lqsg7CpB78IgijfV9DPt/PcpQJrZytxq3L2cGPwR
         laW6yKnVJcISpx5OofxgwM0BE4JhhEmR9bHQqEN686UkmC1gVu/1461DntdIdWBKV45j
         6bczfklNterDGYn5VE7euC9RnDnwoHkqecMyLhnoRnPnrARtjNyEbDiLj46gDCa0aRqc
         uLvHIptAQNh1vsNR8FMsQGOrrfl0rQhE5gvE9aoIuuM+bkB0Y6fux/er9rbz4cBObNPo
         tmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057133; x=1784661933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
        b=sNRwFN5zROPWp/Vvw6ErKsoUWWfRAUwxo4D3mcZyS+Vl8bJGLjTyospkev9rc0f0QB
         5bLdZOF2gL1LfshqaKgDjcL6Ue0bx4iLWHusk0MMJ+SDwc9zEFNQ3dxJopySZ5cDbcji
         XfKuy395aD4DhzZIW2lLxjCMEmwAUmdVKO7tGYsYACapxGcU4AISyKfs6pSKVGGXhTU1
         IYi3o24f4XtD+MBDiT/J4JsSEkTfA0kzWbtNHheTTcPXm2+pjBxaYED/f+fbzPOXdUjo
         79UhV8OESHrqVe12w3Cg56j/SyetEHa6blBc10U3nBPSREwPTiDM0kr8RLdyzp26kYSd
         cBaw==
X-Gm-Message-State: AOJu0YwaRCuvnzw3uFTeKNEsRzQhM+dPyoXySr50XiynGrWeUEeW5K4P
	/HF/c1dIVABnOfzJv5T7RTnO09nmqA+4nGWHZpzKyHhDW/rTHihWGf5S
X-Gm-Gg: AfdE7ckqpPogEATKUz6A/7WERjix6Tv5ucpolRVDwqwYXGLKdYppzBx01lx+68rx12V
	TCsr7jY+kSGvUn5paOQDF03dooFpKt9mpkcvHTLtDdD8gbX14ejFYpKh8opycn+3+iMa7Gb8ZbG
	731+Qk8KoATqZ7RHhfNdMuLIcNEMT+U0zUNA47MVmsfMB5WT/o2oZmjD7XH5Z0CW0cjoHg+41Me
	IJlgJ3HYiHp3O2BF9iYaIYPmpfIdWAWBrOIgtr4w0eX4Kzp4Y6h5/s8RJa2QTgURdBgPIKQoOpN
	b41LFvamh6mjCfqUw0VLkQF/ZlRMB+JPnHbmIWwiVEqCxAKrG6zqmSRwB9Jr1Mbao0s+Wmm8pjc
	xZFZL668Vac7bn0Y3CplQZRR+jJXqwsIFMosQNC20gCupcLmV0A8QzPMsJkCU3yteW4qDYGki6R
	YSgjMmUQ+ZOw==
X-Received: by 2002:a05:6a00:4fcf:b0:847:84a1:9782 with SMTP id d2e1a72fcca58-8488971547emr13217705b3a.26.1784057133193;
        Tue, 14 Jul 2026 12:25:33 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f239f01sm2008654b3a.10.2026.07.14.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:25:32 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:25:30 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mattia.meleleo@coralogix.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test FIONREAD on a sockmap
 socket without a verdict program
Message-ID: <alaNAFBtlPy_acv-@john-p8>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>

On Wed, Jul 08, 2026 at 06:55:01PM +0200, Mattia Meleleo via B4 Relay wrote:
>From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>Add a test validating that FIONREAD on a TCP socket in a sockmap
>without a verdict program reports data pending in sk_receive_queue.
>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>---

LGTM we could improve IO_TIMEOUT_SEC across all the tests if we wanted
per bot suggestion.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
