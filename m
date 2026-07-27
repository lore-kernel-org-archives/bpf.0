Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D56FC5
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195036; cv=none; b=O7OjhS1dOM4HenYR8lNFvMlyJd5AaWoVcFu0NBJp8LrkhtwuSOoX4Ko6SzUnT/bq80mQtGUhuXgGpVS9zFaIf2uI0mZEjZuVbb0FMlj4Q/tQj85UtVFJ7n5JrPm5mNkyqPNZslU0vUTzvpx2uTKR5qqO4Cvuivo1QGe65sWghzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195036; c=relaxed/simple;
	bh=QUEh/beoWmoJNoOtzqrurDuXlnemdk4aF1bLcVqssh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdIotcdxAt2Axxe0F+7khQoCpt+NVTPjz8ESL7eLDJ70AzLsGkwpblVpF1O+mLa8m54m5NDeAk6crUhnVVK6X5JPrFlWaWVlNA13fvGskg7gd3PygdD9XspfsT4SGks1azZleGcaXSSncjfp6YaUbTF+duuhGIZAL8CZS4TBCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ponMEj7A; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ponMEj7A"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848595b338cso3560621b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785195034; x=1785799834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QUEh/beoWmoJNoOtzqrurDuXlnemdk4aF1bLcVqssh4=;
        b=ponMEj7AnvpbOrE2blDEiCrbeB9iMOMi6DoWAv36JEHxy3WBdhXASyTkMCDe9CRiXN
         vIf7i2mHlR/wg2clwvIyeQcr3tGSt+Kfy2SeB3tAVqPr1e1VoB+Bt7zEQ60eKOeHUoWd
         0UhYkgi8xc9vSzWB/RA+SJXK6/9BVBYuv0695NxFg1oPTNock7/Lh+f6E3lZhIie6A/s
         BOo4oKW4fmaeInuRoi3VUjLk563H99maDmS8C2YLy4MHI++CN/OzwSPm9EjKSfvDQ+yD
         pl4bPRgN5CMc7ly2yqBnWbXVUsRDYOpDJVRxD/A/hkhtrEKBblteyi6M38a0I99t6Pfq
         n6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195034; x=1785799834;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUEh/beoWmoJNoOtzqrurDuXlnemdk4aF1bLcVqssh4=;
        b=RXhf0rzjzF4zXta42RvjLmnmL5T22jYuuPxRolceM6b/+KjRFRmmg2O7Ng//K6cptZ
         okwpU8joJBHXBsi+Pn+lTmvgAqgjfyh/G4KItRJtbb1/udfmuBUXY+x4tH0zQrMAH6Ra
         6DT4PhJkaEasstOnkkjK8mlgNds/tvxyvYqvK4hGF8HVl0Qfxj5HIQRQPKAKzhdKz/wf
         dn5VB7DTTT0D9GfjW1uvAJmTGn/dMZKwOa4HlDq/pMCSFNG2L0Tfj3yJYxD4LjV4O+rb
         uQM2CwkZANJ01Fyl6Tbb3B6AFALp32qDBpmzw+ScJAeCV8b6/BAnoE0FzZoYEYW04jdZ
         itCg==
X-Forwarded-Encrypted: i=1; AHgh+RpRcauXJQYJdziFhEbWqJmPFl9cD/7PTbyS1lJtUFrR4lrYcSkBMTZBsbldyhqsUPmqWbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVErAtkAB0LmAsac47TZVucxKsfcNSv9gq3J3uPhhdGkC6N/P
	hQW75OGhO49UJnxOFEXBrgs8FEUZo8J0x1UYCtykv6dHcDl6caQufFe3
X-Gm-Gg: AR+sD13XvKrJBp9x8oR9GVUwoX2bmbAGxhwO8/DwlaI2DsNbNjqjLt2Mf43kz7oIyEO
	KK4jtVV+jJN+UxPKEOXJo4TBBFqkakZfXxZE0nRIUJBXWCICuSnHEvQwp2i9aFJF6v0EVuDTSQS
	h6txdx9GvHkPapk5J3xXeBUDPueGuiSpv4K7UQcTW+S/LNSeqEIVnbuwOX6fsAWfuzHzRkqkesN
	OWbNKoy6IeOrFcVdFHWILJsWp2pNAYQf3+4vPcjyjh25Q9BDTo+2TCaDQ2xLsIoJpnWaNo3LJRT
	7L1JK0/QQ9ZOUsYmpBQJlHlkZDtnXWp/3yJG8hqaYSrXDVIKelwGcy5oipZPMzpDno9uNRdB2Ox
	+2rL68xL3vqDxaoNVAzlA94VtdNcOnzA4LLvVxSIlyXThUq6nszSs542o9FY9sgjZifj3xSnxPB
	YLkbekLKBI8trHzHRbnJOADfqoGwz1anoqToQgixD+ajqsSbvncMg=
X-Received: by 2002:a05:6a00:4f8d:b0:848:44ae:47c1 with SMTP id d2e1a72fcca58-84e8d10f211mr1268766b3a.78.1785195034092;
        Mon, 27 Jul 2026 16:30:34 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53426628sm3647422b3a.49.2026.07.27.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:30:33 -0700 (PDT)
Message-ID: <c3e02d676ed9eefc3651afbb4e4a6c304ca0739d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/18] bpf: Distinguish fixed- and
 variable-size kfunc mem args with MEM_FIXED_SIZE
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 16:30:30 -0700
In-Reply-To: <20260724190813.1458271-14-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-14-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> A kfunc memory-pointer argument comes in two flavors: a fixed-size buffer
> whose access size is derived from the pointed-to BTF type, and a
> variable-size buffer paired with a following __sz/__szk size argument.
> Both were represented by separate kfunc_ptr_arg_type values
> (KF_ARG_PTR_TO_MEM vs KF_ARG_PTR_TO_MEM_SIZE) with the pointer classified
> as the latter when a size argument followed.
>=20
> Mirror how helpers describe the same distinction: classify both as
> KF_ARG_PTR_TO_MEM and OR in MEM_FIXED_SIZE for the fixed-size case, just
> as helpers use ARG_PTR_TO_MEM | MEM_FIXED_SIZE. The switches now key on
> base_type(kf_arg_type) so the flag rides along, and the KF_ARG_PTR_TO_MEM
> handler either resolves the size from BTF (MEM_FIXED_SIZE) or falls
> through to the mem/size-pair check, which validates the buffer against th=
e
> following size register and skips it. No functional change.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
