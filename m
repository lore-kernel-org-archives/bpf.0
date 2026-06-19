Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66142690F9
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830894; cv=none; b=JGox/FNFvrSLkeFVnqXr82YJDbiHqPIbPASowrFYWVoPsyBSUWqhiaq9vVsKViTb1GNyFV0hjvInLgGhsF5d1JKutmBdUr+A2XN5vsxjlAqWsvqyGkfVJQ+ezFs1njagDNKzY9EJJRweOUHcyGwi5uD4pwisZ0DPM1fLFWB3+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830894; c=relaxed/simple;
	bh=0BpQE+MLK8ygVFWMCGPfPCcd3XYmy8dz/lbglEKRlGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDuxBTeSVpOEWI48zWaiizHXs3bPvh89dcSr4DbXa4DD+Ai6NMyvPvjTRNNbWwvz8+MX2IT7AcnAYntqVpCAEnq/lMmFZdUop7HqgM8gRmP3V5u8r0Kla7/gBP3NufwhsBZhANzNwMEOT9V//+S4SYyOkh18tICf4vhaoS1SfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8PpMNOH; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8PpMNOH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30b9e755555so3427161eec.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781830892; x=1782435692; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4Kz/CJlQLDa0qon5uW3Vu21M3pPr+qVXqFwNmQJ4QM=;
        b=C8PpMNOHJdjvQnF80WOCBMsX9lL8LEBN1Mm536+6lZPJa3K17S83K/mVyZ1cGNImz+
         pelyVdgyprUz4P7KNDYlXRSCUj2c11qjDKxxGCyRL3mbvZUZ0KTDh7HlnQUqjRbl53iz
         GiY4ZwdpqopwjcyToqDMNTx4jCm4mFXwwyogVgdkcHCpr3vwJZqeEqy2GycRBWz9HSdO
         fNdEgPOUrzk6LNOv8Xlk+/kJrGe6WyacyOPnnD5+bC4S/mbOLnxPcyZMraP1L8p7z/94
         Rpv0jQpuFxpExM8A5waslHqOVD9a2VR78EyggBElgGHeA8o1ziPvRc/rtdmh1kbsadKo
         +KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781830892; x=1782435692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Kz/CJlQLDa0qon5uW3Vu21M3pPr+qVXqFwNmQJ4QM=;
        b=CKnyIN3WqfS+DjJ1I1U+Q0Vm22Jj3xA5tLZySY4/qCFQbleV/q2oUKlxa2yx2lcL5u
         47yOPvj1agGvtKVSG8rTTf8+ZlQpwn2TpX5KyWh+VsyEuUgC4Vg7N3wjvHFJM8WwHAss
         Yh5aSiJmeRwmVPux7Xxn+gQdLUFPphd6GUijmVoE46Yx0s0Jr9WQknB7QYuPcSZ9blm/
         AeIY8Bdh87YPXiwk/Xjn8S6kX04PC4sAZtLxDOZ/2QB1C8+ybLGK8e78z5BZgb0JCD9w
         iw+WDvF7jVMvOvezj7hiGJ9tVisBECoyoqO0C+R5DU8ASClfT+4oXrL4azQ91lFK7chm
         SGMA==
X-Forwarded-Encrypted: i=1; AFNElJ/au3U8ISGa2fv+9hzURJKvOKDjQgdypr7pEYe0GRLpeYhrQU0u/aDRfIWxVWySGa0K7Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMToWLsxGQ0wOOpYnx700hH3XpcMPcpIRPiuRlpFE8QvIr/w2
	5xdwW1LMQoNqRoIXU8OZwKCW8atUm8sU1L6cZ/MFr5AH+VNCkEeMHe1LHWJhiPAv
X-Gm-Gg: AfdE7clu1vGDgmJKUDk8jCyz3nhTmdQ3LmVwq7a9Xvk25Vfih517UmhxfnjBjJ2fIzk
	SGAIwHmm0ixe80QZdW1NWDRXUalE+seiciHLkK7vuLQagysbLGZnkDLUFwInLUGp4cLZy3Uj4SV
	1agbb5UVH5Cq+M0mQYDjCQCtiT5p4zALuvvSLcYUQN+qxITzr+CsGesXR36b5tvNqBFta37Yvvo
	riA1opcfoaoWMswfvVYIjT3dPP81rpGepWcY/ZTondSx3kEwLzJmIAx7LvzQCUHV3SdwrPiX6Aq
	XWWbObRY/h/horvy8rIPCp0bDA+dgsHisVcqtoDLnd3xkfRsW3FVtQjpGO9zKJ0HduiBq3LbURn
	rwdL4lZmjadEsF5nimLXLw0EMTbEII8MrQ5V7MtnR1j0vvgIhURx+ii53ykvOaw3Rr1ohBDZvdc
	XmuTMOvrB1qHXfggIlejEoWFVbS/iV6Tpe7tbNmtZY75zfJxx9BqPp5u9W58m8eF0pyWuW
X-Received: by 2002:a05:7300:c89:b0:304:e58b:cccb with SMTP id 5a478bee46e88-30c06fea688mr1125542eec.2.1781830891772;
        Thu, 18 Jun 2026 18:01:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ae6d:cb3e:a1c:6cba? ([2620:10d:c090:500::3:8ac8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm985094eec.26.2026.06.18.18.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 18:01:30 -0700 (PDT)
Message-ID: <5c88bd7f01c7c156bb112f0f720dc9faffc7363b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add kfunc set test to
 resolve_btfids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Date: Thu, 18 Jun 2026 18:01:28 -0700
In-Reply-To: <20260617210619.1562858-5-ihor.solodrai@linux.dev>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
	 <20260617210619.1562858-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-17 at 14:06 -0700, Ihor Solodrai wrote:

[...]

> @@ -161,6 +189,27 @@ void test_resolve_btfids(void)
>  			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
>  	}
> =20
> +	/* Check BTF_KFUNCS_START(test_kfunc_set) */
> +	ASSERT_EQ(test_kfunc_set.flags, BTF_SET8_KFUNCS, "kfunc_set_flags");
> +	ASSERT_EQ(test_kfunc_set.cnt, ARRAY_SIZE(kfunc_symbols), "kfunc_set_cnt=
");
> +
> +	for (i =3D 0; i < test_kfunc_set.cnt; i++) {
> +		for (j =3D 0; j < ARRAY_SIZE(kfunc_symbols); j++) {
> +			if (kfunc_symbols[j].id =3D=3D (s32)test_kfunc_set.pairs[i].id) {
> +				ASSERT_EQ(test_kfunc_set.pairs[i].flags,
> +					  kfunc_symbols[j].flags, "kfunc_flags_check");
> +				break;
> +			}
> +		}
> +
> +		ASSERT_TRUE(j < ARRAY_SIZE(kfunc_symbols), "kfunc_id_found");
> +
> +		if (i > 0) {
> +			ASSERT_LE(test_kfunc_set.pairs[i - 1].id,
> +				  test_kfunc_set.pairs[i].id, "kfunc_sort_check");
> +		}

To assert the sorted property, should one define two sets?
{ a, b } and { b, a }? And check both.
Otherwise the id assignments might be an artifact of compiler BTF
generation logic.

> +	}
> +
>  out:
>  	btf__free(btf);
>  }

[...]
