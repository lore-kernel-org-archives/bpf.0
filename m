Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07D373BEC
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077683; cv=none; b=asEvX1/QYYUI9VVpI7nVfo2oOUF5rky95vhCRSHwcdOw2rM9ZCLUEWNKVuCWaZm/vqLpp7fEn9JnWsyiXitY/ALCPQ1wNe6DeeKfpF/nKya8n0+e6V97/rzJzhvnpZ3NM8L7i6wHBUY5gfY3iykulm6uB/1P0M3ME8zXuRWCQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077683; c=relaxed/simple;
	bh=zrz0/ucW3PLwAuhZwtHcOR4kEpmta/vNkqlrXBuJJh0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSUjleRxp6liTyQ9rw/z58jshhFWOpmH2Ys6j2WStSn3oKwMuYARPkHkn9BUtSiGDSSx5CTRhT1HTH6DL8UaDLSBCn8a1c1IwHdvbq5EyI8JLtGZqfZVn8Apt9w00ayCxLa9gnec4zBtsfchAbPmryxFkfwmCTuy5jZWNNarV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjZYMlRe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjZYMlRe"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so219053a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789077682; x=1789682482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W79TF8hp+v+CXkvDz/YZI2YgtWq3JSgPrSm3GoIwkgc=;
        b=SjZYMlRezhWQAHM7K3PpKCa7npyEZISAsH0gUd4kTXizSotAkU7rcerv2y9Nwz8B0f
         vJWVH81IPnMLcqphtxCgjbVuNv3M1+Q/tPVna/M9bgWmQWEXSdDyHQ7Ucm8YCGKPdn7C
         uoJ0MLhOw80y4W5rBHhyj1HOSrQMi2uszilwnugZRYucIWMJl8WCTNHasHcT9hHRjfIn
         /xcqhoXWWCYm1ZnS+KQ/17f+L2zu/8RWpMGoiRSpZ65N/JSJ3sXtJs0Pg7d1Bk5/NYMV
         sV4f0zgV8sVOHCj4xkkwVhyAxH2V3RirR6cQX/LIrCH23Jp53oG0diPpexlKphqxXsnL
         H4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789077682; x=1789682482;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W79TF8hp+v+CXkvDz/YZI2YgtWq3JSgPrSm3GoIwkgc=;
        b=XZUGuFsHdts3XoxrxKKdlyvwrPdKmCn4NsL310ykDPYOeEICbmCdCu9sU6PQRRc8yl
         BYppJrfBoKTMyc7e+UbOrPNsi5JINOj887RzmXB9lEHNROr/ddZhE6frES+wNR5pCKs2
         AFa0zFxIl9xtN0UeIauNcMy03UMzDVZhrfCS18u0Wd0oHd9q14UkGRqDQIjBF7S6O3/N
         e4km5UE48HMLpfazO7uENA0fVZ6Q8EDsfNCfjynxoOnPOcgbHSQocmupqwub8ZZ69+08
         5bV7q+l+0B2uW/6t8bkUt4QHVqDXy0bH0pPlui8o6h4ImlpSOc1sKp+uRR4DjWIBERcA
         M9jg==
X-Forwarded-Encrypted: i=1; AKwUvBy7loov4/CbBgrvTul1uVELar3ahRXgMc18Pvasnn96Aa4lgA1ubc33qpgeLGNdvm6jsFM=@vger.kernel.org
X-Gm-Message-State: AFuF++nPd9ZK8P6qNGohjy+VxrIJwxMNT27hM1fi4lOd2okEDo3F1Ui/
	ZIpj/ZUPxg9DiI9vOSLwfMfePzSMzbXam0DG6o6QcGMzO3XYI9kJM27t
X-Gm-Gg: AYBFou0Amd4Qol3PVbMgQpcQOtSbwgYo0TLJKVGOostwDVxB7DldMKWxP5mKZFNdihU
	NWpH0RY60SNVmZH10pTZuxfrpKSNXei84bxSBR3VIUNzkSKhWw5cRTDwTczq3B+L7oy/bkoL7Bm
	aKTG/4r72DROBEdhucVli+tsBDRx2W26XIcw4p4kTQL9yjTtY3tq9TawhMsPOEnq7FD5fXak+sz
	m55qtmiY/VpRc15f4/POktRpGH0+Aj0bZlH1Bo1Nl4XEWGPQ+LL3ZR1P04ev+GZKfIcSuyc0AzB
	euh/lCCYfHROHyNNtrJtpfTobtwH6FKkZSFU7kxtp6NO/+/6a5GHtIvA4ZjbPS6oL1J00+LZBB4
	TvIRi7Y5fIutBXMAujavxAIYQ1oihvQ1s3Fb5dQlFsZ0XhEP85RYk0I336bIwiCrdtL7BbsAYho
	LLqwMICM2GhThaCa51J0VI7LkoKfmdz5agNS5fV7M2lBFpw9PNw4mbS+UnXXXCWG/QUCDa/AoQv
	kclv1TFSDP5dhRWvgLla9PqKwVs+IXn7/bCiAaTJ8JjiA7ulLIJddMGMA==
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39d9c3a1fc2mr1365490a91.24.1789077681667;
        Thu, 10 Sep 2026 15:01:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm2152282c88.12.2026.09.10.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:01:21 -0700 (PDT)
Message-ID: <9b3ca4f410cf1f2af0464df282fe017ae801bbd4.camel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test BTF walk into a flexible
 array of zero-sized elements
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan
	 <shuah@kernel.org>, Yazhou Tang <tangyazhou518@outlook.com>, Amery Hung	
 <ameryhung@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, Tejun Heo
	 <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Thu, 10 Sep 2026 15:01:18 -0700
In-Reply-To: <20260910122316.186384-2-jiayuan.chen@linux.dev>
References: <20260910122316.186384-1-jiayuan.chen@linux.dev>
	 <20260910122316.186384-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 20:22 +0800, Jiayuan Chen wrote:
> The program stashes a bpf_obj_new() object whose type ends with a flexibl=
e
> array of empty structs, then reads it back as an untrusted kptr. Without
> the previous patch this divides by zero in btf_struct_walk() instead of
> being rejected.
>=20
>   # ./test_progs -t verifier_btf_flex_array
>   ...
>   #602     verifier_btf_flex_array:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED
>=20
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Please simplify test case as follows:

SEC("syscall")
__failure __msg("access beyond struct test_flex_batch at off 4 size 1")
int stash_and_peek(void *ctx)
{
        struct map_value *v;
        int key =3D 0;

        v =3D bpf_map_lookup_elem(&batches, &key);
        if (!v || !v->batch)
                return 0;

        return *(char *)&v->batch->events[0];
}

Also, aren't there already test cases for flex arrays somewhere?
Probably no need to add a new file.

...
