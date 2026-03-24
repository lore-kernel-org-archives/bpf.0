Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFE391E55
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373679; cv=none; b=kb/XW6UTYUK0Q2m9GKKS4mFb7EMN7JNwlwRzLWtbLX177ZgVxRjrGIk20lhMaFJXF/NRZ9qecR/sVyxEZx833mP9MehbON5TvGDWt8Osp0W0DauD8bbtyVaNjDwdirs4WNTt91IOTcSx77kIa0lAnk0VzBwZtvRdERSd/Jv6EaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373679; c=relaxed/simple;
	bh=gywsNUK0xaQ5/M5DTfuh2A78fRzck1sU9Y6jpu4e2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe9kyStLz8yT+b6999YUgQTzlJ1weLvq5W2fSsw9WMa+U9IfH5ijBhLjYacHGSzba2x0q+tQwEWhyD/bDdZY1Gt7ULXwHhYaTXSOhtUgy8c7yRCZeOxkSQ14Xc3Qq4icrtOlvQvdV/4AoUlzvx9thVGjzcBgFLYtQOMYy55F9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xObZ/YQ3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xObZ/YQ3"
Message-ID: <e5a2ad16-d2ac-4fa0-be41-162227257682@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774373665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ws42Rf5aPBnDXSt/oJVoEIiUzpyDal06gBdo0Z7vkQ4=;
	b=xObZ/YQ34o/vPvH/6jC4FDj95XmRIFagmpTMrcCf/gzyFw/TCiEKEoSoqmSLpQAWsh2KrU
	kHDL34O4ivK3Wsj/rDI2CtlZKUd6JFnnctF6K4tGeqi6ZFpZs9nHIA0IftTdBlyY8WNGiZ
	amB7vZtMoTFb0N2q/7QONEZRaotwP8E=
Date: Tue, 24 Mar 2026 10:34:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room
 flags
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Max Tottenham <mtottenh@akamai.com>, Anna Glasgall <aglasgal@akamai.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-2-nhudson@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260318134242.2725749-2-nhudson@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/18/26 6:42 AM, Nick Hudson wrote:
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.

It would be useful to demonstrate the intended CO-RE usage in a 
selftest. I suspect it is bpf_core_enum_value_exists().

There are existing tests in test_tc_tunnel.c for the earlier 
BPF_F_ADJ_ROOM_* flag additions. Please add similar tests for the new 
flags introduced in this series.

