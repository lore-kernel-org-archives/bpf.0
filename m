Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8502FA63E
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770967; cv=none; b=d60yx2JOhR65YAhf6BPfLKarAWaG9m6mP6t2933/jhJKBipGvb0xfjap+HC+X+RFQ+yUGMYQRpfkBZDhKLYtNXllfUMwv9EihRGNYcuOUfMrj+B3ouqvooLOY1Xh1Ev91jp2e3Edql+yUjNuPZQx7w9UWDr0rUAVsTblGww4H9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770967; c=relaxed/simple;
	bh=lzxjgkiO17y1kknVkxUwA03wmFH46rn+pwTM7guhgC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE7onFtCmvDpyXMlnHAjK7xbuix9mN/Z/ope+Vbpk6A18Vt5+VMQcCki/gGXFewYmAuZPDCNOMiNkGS1mbgmexJGmU9XTvyBHBNpNioVWCLzdsfK7NmeAecSlBuwUtKW2O5oThojQsRJdSDdf10lMYGNAV7RRLpx00hT9l+8gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kgOG5wWF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kgOG5wWF"
Message-ID: <f6c4944d-c6c2-4a7e-8dd3-791d0c29022b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752770954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyhHdjw2GpmeF7/B7DnThd2XfKjNSuRZ4w/Ep4jyig8=;
	b=kgOG5wWFpRnxRKx18sTU934evaU58k6Bpu1zC73MEkis/puykwthk/7keQ/ORhuXAnco1K
	w1dwo9fDWtwtR1liS9aKCa+UW42IgOnZ+gq3Za9ypvJA7N6jEtvAFIk1kOj0e2OlowXDuf
	j3X4Ouq9zYWPjM2NXaWaH9wCHSpVpJY=
Date: Thu, 17 Jul 2025 09:49:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in
 bpf_object__new()
Content-Language: en-GB
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/17/25 4:59 AM, Suchit Karunakaran wrote:
> Replace the unsafe strcpy() call with memcpy() when copying the path
> into the bpf_object structure. Since the memory is pre-allocated to
> exactly strlen(path) + 1 bytes and the length is already known, memcpy()
> is safer than strcpy().

I don't understand in this particular context why strcpy()
is less safer than memcpy(). Both of them will achieve the
exactly same goal.

>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 52e353368f58..279f226dd965 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1495,7 +1495,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	strcpy(obj->path, path);
> +	memcpy(obj->path, path, strlen(path) + 1);
>   	if (obj_name) {
>   		libbpf_strlcpy(obj->name, obj_name, sizeof(obj->name));
>   	} else {

