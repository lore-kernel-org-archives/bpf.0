Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733E3AE6E4;
	Tue, 18 Aug 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042662; cv=none; b=Ar8X4DKKDMtD8qQpCDkx6z2tyMzxkTP+E0Pq7dH2YFLOpVNtDSXmOmEq/bEk2KXpQ9vAZpGfG/SM7oNWGsyyW8MaPTHe9loLcEOdasC54J5cfOmDhp3Is5thjJa4FzJH3o/VzrcMNERbCnUK6qfVjSpRh6jEVHt20ZTHA+dpl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042662; c=relaxed/simple;
	bh=JlpKxHdPLyTS3/kJCUTnF5QdL9O4f7VTzmfV/S2fuWo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CPwp9Bs14ZcArPF1HliAhDb/N2OkVJNy5JF1dQ8YgGunIyCv2MrJbC/zaRvyOifUld+jgrlekl4cA+7EtvNLX2Te963mlIVp7WtPdnCM1L3iH81+ggPRP3uUvthe+GkHbNSmvw2u9ErAjQNbs8HSyn9vGXzJipEdKsPqPKpm6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75971F00AC4;
	Tue, 18 Aug 2026 08:44:19 +0000 (UTC)
Message-ID: <39026ec5-d3fa-47c3-885f-2205a8bc61e5@kernel.org>
Date: Tue, 18 Aug 2026 10:43:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v5 00/15] Fix leaks in rc core
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org
Cc: bpf@vger.kernel.org
References: <cover.1785338381.git.sean@mess.org>
Content-Language: en-US, nl
In-Reply-To: <cover.1785338381.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sean,

For this series:

Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

On 29/07/2026 17:22, Sean Young wrote:
> Changes since v4:
>  - media: redrat3: Error path leaves device in transmitting state 
>    - this now removes the check for transmitting boolean in transmit as it
>      is now redundant.
>    - Reworded commit message
>  - media: rc: Use after free in ir_raw_event_handle()
>  - media: rc: Fix race condition during rc_register_device()
>    - Reworded commit message
>  - commits affecting particular modules are sorted together
> 
> Changes since v3:
>  - sashiko had many more good review comments
> 
> Changes since v2:
>  - sashiko had many more good review comments
> 
> Changes since v1:
>  - sashiko had many good review comments
>  - Added fix rc: Use after free in ir_raw_event_handle()
>  - Added fix meson-ir-tx: Ensure probe error is propagated
>  - Added fix redrat3: Ensure all urbs are suspended
>  - Added fix media: redrat3: Error path leaves device in transmitting state
>  - streamzap fix was incorrect
>  - Other minor fixes
> 
> 
> Sean Young (15):
>   media: streamzap: Add missing rc_unregister_device()
>   media: redrat3: Ensure rc device is freed if enable_detector() fails
>   media: redrat3: Ensure we don't read beyond the end of the packet
>   media: redrat3: Ensure all urbs are suspended
>   media: redrat3: Error path leaves device in transmitting state
>   media: sunxi-cir: Ensure no more interrupts can occur before free
>   media: meson-ir-tx: Ensure clock is disabled on unbind
>   media: meson-ir-tx: Ensure rc_free_device() is called on unbind
>   media: meson-ir-tx: Ensure probe error is propagated
>   media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
>   media: cx88: Specify rc type at rc_allocate_type()
>   media: saa7134: Specify rc type at rc_allocate_type()
>   media: rc: Fix race condition during rc_register_device()
>   media: rc: Use after free in ir_raw_event_handle()
>   media: rc: Fix use after free in bpf progs
> 
>  drivers/media/pci/cx88/cx88-input.c       | 22 ++++++-----
>  drivers/media/pci/saa7134/saa7134-input.c |  7 ++--
>  drivers/media/rc/bpf-lirc.c               | 18 ++++++---
>  drivers/media/rc/ir-hix5hd2.c             |  5 ++-
>  drivers/media/rc/meson-ir-tx.c            | 14 +++----
>  drivers/media/rc/rc-ir-raw.c              | 47 +++++++++--------------
>  drivers/media/rc/rc-main.c                | 19 +++++----
>  drivers/media/rc/redrat3.c                | 40 +++++++++++++------
>  drivers/media/rc/streamzap.c              |  1 +
>  drivers/media/rc/sunxi-cir.c              |  2 +-
>  10 files changed, 97 insertions(+), 78 deletions(-)
> 

