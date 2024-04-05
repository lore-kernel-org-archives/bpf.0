Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F491CFBC
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335075; cv=none; b=WQzX2Vx7fP96gThpedmndtPpjtwZQeKTp6qEjMGJP54kBVxjS6gesgidBmtA37EgCu3vkRY/ex7l+mMJU3Fg9weOZN6r2SvyG6PTZhO8Nq0L65QNH+rI9HDyhEUDppDbnJrQVLw3bI3fd/nWl37yOFIKUgHabl3CRz9ClSnHKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335075; c=relaxed/simple;
	bh=rHAUGtIF2AXVhtJ8pWLF/P1HUlpGAuTBYlo9XczDqkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3FmgIW1T4Cl2PMMXwdMsVvaJfT8qFDQTZ1wsRtIAmClC8lCqz+H87N3XUl+KjWeJPMBpJlxScAvoB3Hl3P545L4pp0YBYlLtVq3pevXjAmAeBGDZHnxcsROsAVwz7roebQokpmwzC/Gm9u2Fl3fEbo8co7E9JwPdm3KGNUalHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dP5h2k1X; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dP5h2k1X"
Message-ID: <625c7c57-734c-4f68-a1cd-7865a0ec0c48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712335072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHAUGtIF2AXVhtJ8pWLF/P1HUlpGAuTBYlo9XczDqkc=;
	b=dP5h2k1XI0CrqCM4MuXGoWuELTiquKzMGhj8FKOk+leEEMXgpriN6QmiDrH7/LMM+hLH5f
	DRInVac/FHFOAr48HANH50hML7Sx2XS/VmkeM2xb4pdUD1BnFawYWngxaveqldhMgnsQkO
	0me29lzaQobwE8nAh5AdMaSr0eNFZ8U=
Date: Fri, 5 Apr 2024 09:37:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/3] bpf: allow invoking bpf_for_each_map_elem
 with different maps
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
 <20240405025536.18113-3-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240405025536.18113-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 7:55 PM, Philo Lu wrote:
> Taking different maps within a single bpf_for_each_map_elem call is not
> allowed before, because from the second map,
> bpf_insn_aux_data->map_ptr_state will be marked as *poison*. In fact
> both map_ptr and state are needed to support this use case: map_ptr is
> used by set_map_elem_callback_state() while poison state is needed to
> determine whether to use direct call.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

