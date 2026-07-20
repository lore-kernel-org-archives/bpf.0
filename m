Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCC883F
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536851; cv=none; b=ddFv5WLrHEOO5wU9VLx3g7M+UI3ElrfivRNu5mtEy/u+FwQcB+IjFedKpAP5Wo2K4UGtmajrnGY68It3U90iRyoHEeEMdHo3PnRZ/og+Vv01wVq6EyYGmaj6l9nYM7Zu6lWYj3fFP16EV6+kQLHtTMu2ZEEVGMWwXqfCXYmXQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536851; c=relaxed/simple;
	bh=ilUM7VN6NQ5TAdAOTNeDEAJgBMcCj3T3MTWqjo4n8PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyS207u8izVLI6OcbSn+0/1AIMLaviqKYHW8NswzXUpGysjzLvFGEbDpLwX3U2K7mpMy4AHgNCciw5FeAo+hmR8C7HO1nfs16DLNrW0IZXEGvDsu/zPBCoceSJ6cjNXg1+H3EPRdBxOJ6b40ycC64uhqp2i0hq7TSUQDe6ZMR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZChRBOv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZChRBOv"
Message-ID: <e30b9522-bd38-41fd-93fa-3b8dcf01a3e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784536845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rJVYAfnfINPkfXYzySs+bbSGm8qaQL70ijW/jzanFA=;
	b=GZChRBOv1yRm96qj4oYWH4D17mgsDlu1T4WEqKKGYaRNYdmvEddKRPWr7ot4emYg7JagvX
	w+ohzhGR6zl20qcFDyo+TMb7ZHdSK+CuP4SpEHvfWqurLSuvjflmAyn0kXaqlnlrb7vWki
	zhh7QbMtkst2AJp9tC4ZLzRwHqmQvqc=
Date: Mon, 20 Jul 2026 16:40:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] bpftool: Skip prog/map that disappears while
 looking it up by name
To: bot+bpf-ci@kernel.org, qmo@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260720071520.396363-1-jiayuan.chen@linux.dev>
 <4054b8846ea1b4cc0b2f5865891fd4add21499034aeb66adcd9e2fddf16cae83@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <4054b8846ea1b4cc0b2f5865891fd4add21499034aeb66adcd9e2fddf16cae83@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/20/26 4:02 PM, bot+bpf-ci@kernel.org wrote:
>> commit 084a91fc9c087ee9f5a2163da8368590cad6f121
>> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>>      bpftool: Skip prog/map that disappears while looking it up by name
>>
>>      Looking up a prog or map by name walks the whole id space. There is a
>>      window between bpf_prog_get_next_id()/bpf_map_get_next_id() and getting
>>      an fd for that id in which an unrelated object can be freed, and the
>>      lookup then fails with ENOENT and aborts the whole command.
>>
>>      Skip such ids and keep walking, the same way do_show() already does.
>>
>>      Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> This looks like a bug fix for the prog/map lookup functions. Should this
> include:
>
>    Fixes: a479b8ce4ed1 ("tools/bpftool: Move map/prog parsing logic into common")


It's not worth backporting it.

People can always upgrade bpftool to latest version.



