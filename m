Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CB39794A
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889060; cv=none; b=bdwhh+107M34O1ZdN8GlRCAZv+f43WFWYsrigV+dKcctJXEDfHOvQgthezDCrXyP0qE34nQtyAUMPmPnQgoV1wCc3W0hHkGqMGAfPZGBa+bYxqC2TUGgxxnb0EDfvl5DRz6/B5po+TKCkmFiutTB1OGuVA9cM691to7eHyODdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889060; c=relaxed/simple;
	bh=yrD9iOqDSB+oA90GXdxJg3QYf9+2okRVN+yypqMaCMw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=njH9yKap1IVkZqQAk1NDrqW7F4+1df8wB/1MV4I5JZ5GmTRpKeO+c1zvRIW6IOzXQE5+98/wIc4jpP7zOf/ujZK6KykZ3DNaHGqWhWD8liAMrot4eZVj2lcqhWlghcmaxy+typ5qL10NzZDKhjEl3Pkro+l7rbXqunFDFjVJIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNg+gNHB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNg+gNHB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39686abd426so498492a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 20:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889055; x=1788493855; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2wKk+vB+goqKaLt0KMnxh7usyJz614ylfhLbmhKrkpw=;
        b=tNg+gNHBwrm6Czb7+1YXA7m/VPYRAJfjrLQwWkwPI7/WMsAJcUyj+YZhe8fdsNmVMe
         bDHttCaPNPeym2foe73qBZMQdhm57Mk0Nc8rspwNXOEGBTf+lt5O9fvsGonUSxd0UobP
         Q9+p/ImuF3DQ/hjk6CNUVToESB/iaaVxCsT59Os5MzALpoAILPbIdrcmz4hN5TAIY/A4
         nsRCPv+TsZIpAsvTWCzVOYAeUdM792+u0QLg9izbIwJHZJdoB2Z5xEs2Y8sJPIG+QFJC
         HIJBq4DV8CxAaXcxjZsEdV+DZwfzCMQ6aq2TBnmDw1IQB7F6VDImJuVI9b2u1NeT0CYU
         qMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889055; x=1788493855;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wKk+vB+goqKaLt0KMnxh7usyJz614ylfhLbmhKrkpw=;
        b=bDTjzzjc1QGrlq3gtna/AS7oa0GuD7ktuyICykhXPDhxhT8FqZ6+LBvowveY1Ei5Dm
         ZQ2gjBx93Is6Zoh2U7Qt9pPolhlXcywUYOBw8SS1iFOHUx4k8AKt4NDYZ5CUjGpCKQa4
         xfLLj7M9b4HHaLd0gtiLDlUrP45WP7JIUuB3BhlewhYD1Jg1VTsGcZzMUvvKSFOJnJQk
         dPMqjXzXlHrmbnxy39kfEwtN7bv3Tf17QEmtDrUypgI1HViDVvz90fxqgEZo7sfhhGc/
         HsbWjuivtLf7urnmV727rrlvz+68hBUGXytngucfCV5BQv3AJIOb9/YtlyZztDMJJAbm
         bLag==
X-Forwarded-Encrypted: i=1; AHgh+RobridxR/m6BUPia7bLvrWIR+7Ank5OgTHdt/5v3EQDuy+vEbFQs6iheHZ6JCzGNiJOnqw=@vger.kernel.org
X-Gm-Message-State: AFuF++nC9rqUZ1WB99I7oqFze2rD6SyQzWbCC2aeQWCnB3F8DMxAHKbC
	UlLdr18qiCZkjmdiCv+cQ9ApTtHbEGa+CEL7ZslaW+bdf1DX3Q9tEMcy
X-Gm-Gg: AR+sD112dBL8jkKscbj5pv7dSJyVLl3Z4/XTqaRPs3FgxTLDIMWTg5F3eh1R9LG9QO8
	xrCCE+BTOo7fjusS8YlERi/CydALzBOILNDEqA4hkyfrE5VPyEL6wguJ31rPCeqlj90G/Wi7Ihs
	Pa9wmuADHZxBKKETTqH1qwX8WU/iip7xHucNR9baak2ULWSxLV/OrYaC1zWYN6kKDdvvV2yxe31
	a9pmtmKeiJkscHkPeU+4gYXtQ+FZhb9XxXqqxUpKtpk2DaB4isX1DW9xz6bT5cM77DJf1XB2Mp1
	z+iPwE4QTa+W/M/hOvDAzws3N8CiV0LNtvIdP7kOShOVST+NpgCpzuh9ZQoL+Rxv2tNpGzAJd76
	hZ3jIxoqZ5uxW5bjrFOl76nJiQlLmT8Ar2lSgOpmJqiEHKAmMbJdA9Ebg+Lm46Mn7zdpcg/sWXz
	Dv/2G+t0GNcpVa+brCSlT97b/Iryj8psfGw09aZNNNXLn/CEdkzYLCSedjbrOaPWB4Hw==
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-396d0e5bbc0mr8463160a91.2.1787889055213;
        Thu, 27 Aug 2026 20:50:55 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0e0e67dsm1659184c88.15.2026.08.27.20.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] binfmt_misc: document the field delimiter
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-3-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
 <20260826-work-binfmt_misc-delim-v1-3-43618adf8599@kernel.org>
Date: Thu, 27 Aug 2026 20:50:28 -0700
Message-Id: <178788902862.3236768.2911438482058639296.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 17:55:48 +0200, Christian Brauner <brauner@kernel.org> wrote:
> Document the field delimiter.

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
