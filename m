Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB21A275
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959111; cv=none; b=XpBbOkOtvQ4GSo/oiU55wBrOaah3PIgFsLxZ+VAuX/UnNnbBAOx+GrUg7CEClxbmOZt1B36HmRZHhTxJoSdGxxXBsbScCamCDzdvAGiQADAMNne6SRXTZCkddWdU2VAIH7TJMOYOtxsckUQ4lulxjDigIydbxz//hxF+4d5T48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959111; c=relaxed/simple;
	bh=zc8M8DQUhdHXa9h3ZwAhTTdeTqYKFbRybBw2Dibexp4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ONXj64VkA4EDMXVnjIk77aes6q7fTzdHyE8Qc4JiExy24ZP5YoQdDl8tV7b+KB8crjpe0i3V92LulmmuYSHVnzJQ/T8pFsRxr60eHDXyCmaf4POg7NC2abizwzAXVJ7rL666BBcGc/l+K8hStICep1+0mWqyP2DFxZRhZT2V4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/pyfRtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/pyfRtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0FBC116C6;
	Sun, 12 Apr 2026 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775959111;
	bh=zc8M8DQUhdHXa9h3ZwAhTTdeTqYKFbRybBw2Dibexp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=h/pyfRtX3dZRo5VcPZqzmIhlI0HQJAxSva8uggvINsDMJu9c6kH058TqdUq42aFKS
	 lgY+uvHaocD8oJ0DCQFF7MqdJAiGHQGk55k3AGnOLkX8Fpo7/8RFcZo73RGvUMtPde
	 uDv6GUkvVfKYRKe6DyDJRmfC5hDU6AoOLgXolWYDr+DQm3jAxnrLnq+doumO9BLhnK
	 q9z6ZxuTdOBzKtF5eXoS5szvxbO/M2JGX5C9DN3rAJm93tI5Vh0p90SGhKhlBvGv7F
	 OQajxEiNvxAxcAJK6zw2xQCE6Ba9+Nw80ACCaYrzKonPNWQ+/OHAcNu2gmS6OxgAa6
	 oASAPLnNSa3xA==
Content-Type: multipart/mixed; boundary="===============0468749040718177764=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <418fab535f9821b82ddc645cdd17244a144bffa5e6a0af4a517e92ead7dd6ffd@mail.kernel.org>
In-Reply-To: <20260412011857.3387-6-emil@etsalapatis.com>
References: <20260412011857.3387-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 5/9] selftests/bpf: Add basic libarena scaffolding
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 01:58:30 +0000 (UTC)

--===============0468749040718177764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
> new file mode 100644
> index 000000000000..5acf9b994943
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#ifdef __BPF__
> +
> +#include <vmlinux.h>
> +
> +#include "bpf_experimental.h"

Is this include necessary? bpf_arena_spin_lock.h already pulls in
bpf_helpers.h, which provides bpf_stream_printk and the other
helpers used in this patch. Song Liu raised this in the v5 review
and it does not appear to have been addressed in v6.

https://lore.kernel.org/bpf/CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com/

> +#include "bpf_arena_common.h"
> +#include "bpf_arena_spin_lock.h"

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24295891016
--===============0468749040718177764==--
