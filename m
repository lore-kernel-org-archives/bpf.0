Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32F36EA94
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821770; cv=none; b=C7wnuAqidxqX9Z5cSOGZy6FwxLg/f7XdWETa5ddFMrHb4iOH9gK0MSBmpBxEt0V+aqXWv0kD5x5TMec2aNpG/hQVOVmFw37PuFr5Nrm1AH74if/hBMOWxmooYBWzxjG7ZWD7YKxEwA2UKZrJLyl2XIjaqBe3HX292Z0ELlll6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821770; c=relaxed/simple;
	bh=+sWnZTZI7tRDagieoGZ912iRmUTtk4dAhIpGp/Vjdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiXFHCOMfQ/q197P2VCo82+YY0ej6eMhs6GFvcxn7xLgGAeDXPRzJClfc6744L2jXW5yeb99K8sulFipcL7uAqR+MzeA0IP/AylWjBt8mI858wXi315LWgsXvDRMpwZK11tHVIZWpdfbYc0GnNDjjzgoL8+041mc65Lt+F5E0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSq2oyEJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSq2oyEJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so2598153b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773821769; x=1774426569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TyRCY1PjbaXhBQLCPF3GQ7ptO1QobaJ5bFC82lbNs0=;
        b=ZSq2oyEJ6bTBf+wU/OVe1+pnqcBqNrqcx6KgPDgij95lIqLNgvZyjDfPc1L8vrFCiN
         qki4zNWh4A1odWdzDtR7ZOUiHhX9V8ePpEVUOjDPkU36wVSCuMG+PG8vUvU/bvUjCNnW
         QHkYMAQNLGZI6nu6/yhsZU9tjxfhmVWPTjV1Qqy5RCaDQ6lPEYc2VO/I7Ai7MIce5FKq
         rz2BmXipCd4dybhZv00FeLP42JQ9r0enewBgX1JZ6MiPOBfmxGByqoh0rUYWqtLoFQIS
         WuJG1jNXBdJQkIepavlm+wfai2ttZGXyD6zZj4rLXuWLBv3t5ysH+7wPgs/mIlW6kWR9
         lmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773821769; x=1774426569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TyRCY1PjbaXhBQLCPF3GQ7ptO1QobaJ5bFC82lbNs0=;
        b=YSLzHUxEETPu9WuafY5At6Q7VW5oSdIQ4D47wG5P9HX+dp7bqskf6rNXQQ8nEhOCZD
         9lWE2x9GmfzNJjbmm73li45Wq5ABzJeLwbBmHgA3O8kD95t4IYBv+IJH1bTa99wukTQW
         giTDJxi9PI9F9/Z/G+h0ygrjQVb3GxIzjDHAQMeKP7dW52SxLbwGMhi7meC9emDu5ykA
         DNYgkflYxf/CFznKpEpu7DmURKJCH6KPU3PdT6GJiI+/TA1F7hdKRmrIprMSixkcOyBe
         Kfhf27Vnix/ijMsdYjeex8686STDwDy26NE99HIn8QAXiLewxuUVlHwkNYKH53Ej0c7i
         MzDg==
X-Forwarded-Encrypted: i=1; AJvYcCXpCn+qDzqudMVQvmrJxiuU+u//gSctXaRnDkOL2icYp69cO6K60XA0OEJduRww8j915mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDoluxHWpe4BlonM/aYB5YaLSETXJahKz29VmGDSNcIsTy2/F
	lO5czJgZEfowVFK8kNyu36/Cu0LG4N5dv1azEx++SBAg/9BanJZvUBRr
X-Gm-Gg: ATEYQzwk5+qtK23DwQUfhRlaYAqVWgvemVOdno1lOjh9qgdp35G99tRdtxlNnFDuptY
	eSAeGK6iNIQXiIR1wJHaC3P3SGYOXuNrYlT0Le7VJsyLg4kgaM0/FEmm8YUv80vB/luU1HM6rnS
	n0DQa6yF1Srio80ZnCp0FvaiwMuHuwHlO9UXK7isWNCvQ/lHJv/un0A5wlRXXtl1s4xzCmQi2rS
	5UYZtNakzDKw8wVjF/b9pBTRDwUVYE5knn3opM8Yp0G+FnFrTXKw0xQxCFyoYehbnH6LIanwN7V
	abnKLqxoB9COjn3aOTHRcWLV1i0RFTpG7w8CWQtAo+lM/oJIdY29UiELaVP0DlSad6yLHpPJtOV
	E7D6pRUoVLaaVzFhEFgGRS1VnfnFYaiIgpancf+4GvaWG1uau0z3cJCZu0UvHliNCb4w7ce5EZT
	WjTEtAJC/cViQdR0fBooU=
X-Received: by 2002:a05:6a00:ab85:b0:827:2c46:bab5 with SMTP id d2e1a72fcca58-82a6accbdb2mr2518596b3a.9.1773821768522;
        Wed, 18 Mar 2026 01:16:08 -0700 (PDT)
Received: from eric-hp ([49.216.25.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bddcd43sm1571348b3a.50.2026.03.18.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:16:08 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:16:03 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Ke Zhao <ke.zhao.kernel@gmail.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2] tools/sched_ext: Update stale scx_ops_error comment
 in fcg_cgroup_move
Message-ID: <u72uqrur3f2jcskh3hjezx5wzj3nkhrdmniv3yba424oozb7oj@tx2b7vawmqmv>
References: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>

Hi Ke,

On Wed, Mar 18, 2026 at 02:14:57PM +0800, Ke Zhao wrote:
> The function scx_ops_error() was droped, but the

Nit:
- s/droped/dropped/
- Use scx_ops_error() and fcg_cgroup_move() (with parentheses) in the
  subject to denote functions.

-- 
Thanks,
Cheng-Yang
