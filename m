Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721327281E
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229108; cv=none; b=p95g9US2Y7NvZDc9LAizaF5KHO3DaZO5lojvsR22YnDiQC07/CwNKCdYsedw8zBSLqeHtCjdoI3eeaBVyF3mBG1weYBdvczxVDXHqLAbpsVMh+fodtY0Hynbp1jFfCFA1TGFtFhA9wEpAt3FxzROyet5/qBF0tDeOHf1iQgau7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229108; c=relaxed/simple;
	bh=R8Rdkk6V1wt2lHY+WrxQIoVTpJoczmmZILMSNoRxAzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqnAOcEjhZjlaqPDadA5vZLQkl3rKmGihPyFD+gaBuoQfwK4Pj/UTi5mtcCaC3hTWZ6vyOIKgKlwHhHoMp4qQcUtUgieN3V86fUuDNl4yNCWT3ijScRgUPU3JNJrZfDwl13wioHmDQ0Et+eJkEDAIwpVY0YlNgGriznFPq1fUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FySWJTIQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FySWJTIQ"
Message-ID: <9eecfab7-afac-4144-b544-ac715b07980e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779229094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2WT9FePIUjkg4Kg74LgGvpX1oCtjDVlmNgVfFvpu+w=;
	b=FySWJTIQIykP5rlIJx0ewp7HYbLstrpX9oD+YXskFPjUiYCW7mjZySHd59H6OOzpEkrzJ6
	hoN/57ozoWCVA6XnSoquT81hvlQ3EtKJN5uOY9lvyESHsq6CcTViYVrE97Wl6B8WREvnEF
	eCK8HEBsibrRtI6j83djIky/31kdOao=
Date: Tue, 19 May 2026 15:17:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
Content-Language: en-GB
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260519203858.1342507-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260519203858.1342507-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/19/26 1:38 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building linux/bpf.h with -Wpadded shows an unintentionally
> added portion of padding because of the 64-bit alignment:
>
> ./usr/include/linux/bpf.h:1510:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
>
> Avoid this by adding explicit padding.
>
> Fixes: f28771c0691b ("bpf: Extend BPF syscall with common attributes support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/uapi/linux/bpf.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cc4c0b62cdfa..0f0ec00cae4a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
>   	__u32 log_size;
>   	__u32 log_level;
>   	__u32 log_true_size;
> +	__u32 __pad;

Let us make it as
	__u32 :32;
?

This can avoid people to use the '__pad' name.
IIUC, typically uapi struct won't have implicit padding.

>   };
>   
>   #define BPF_OBJ_NAME_LEN 16U

