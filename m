Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9063218BA
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102781; cv=none; b=W/g3Wigp9MYBQt550hmhY2QHQbePFqjuqhw5wLPJ21PSqjSLOOjnFWjtYalAK1i0rgv0HZWbtGKVmvplZVrnQYo0kbV0dNcTf0amyhx44nku+TaYMprNazWYimGb0ymJJHnPOUm5JzjUI/Cp5Msij5b8XrpkiErz3W85CHrj37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102781; c=relaxed/simple;
	bh=nTVQMey50UnzvvyZ7z2R22Xdnm5sqI2qMUvaYzyCAaQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=spcKRPKeZ53I5MiMmWs2nIoKicRbecMwB2Ojpgp3DcnZdoxnK+ZmTl3PNaIPEoTB5/bZ1u1kYVo5HMGhnOm24ERx6DjYOpEjnRtdZb7FjMbsD5nx5Td4B9hkfEsSLC2kfOFzu1zvM0m5TEFWJJlx3sS0nooUwUVqLVNBr94bEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soabn2Ft; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soabn2Ft"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a3490bso219356b3a.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102773; x=1790707573; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DlGmU2tr1aC3QLpKPtGAeCfgB61Lr6xQ/wV06DTCoBw=;
        b=Soabn2FtSRzatHhV3Nnsw86mNIj6fZMmyNxLBcFTpeLfWYjdla2LHV7hTZc3kHdj8A
         yJcV3YUldA89c9tO1HBkfv+8t8YnmWCPCrj2b00iyUDTnDDT1agTzUS0oxQ9SLrIs/28
         XCutNaI8MITaEBvMJFFSxNl6/+zvT0u0ebW498071ZBiXcKetzd1DZ+Imuz0uo5c5nWm
         cHU9Enz3qVYK4d86fMirUVV74lrhXmnsbAFipRVmcP6emyvCSgUMcFVdgkPsVxex7m9t
         L7KAbTw/K0NhGvb8RiE5kkCKTPgpjV2qJSOpO7VGQIukBbUbVfFwXxoJB82+3FA8dsIW
         peiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102773; x=1790707573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlGmU2tr1aC3QLpKPtGAeCfgB61Lr6xQ/wV06DTCoBw=;
        b=aAzIzmG8Ku6E783XzcvTEK8MUky5T8nkJDPBBoZGN5PEcmMb8QCbVOdGaIv/BCFQjG
         7334xPA8d2gW252k9rW1qA/47dm9mMbxx1hGvW1YCC0OH06xMXXat5TSPf55ag7TPX6M
         YELmP0q+3WAXCVROMc3kEUoVtZrEgNn9dOf5wIyVrnRW65OYSc8q10v25TTYKeTpMumV
         Zzc69FZrFveT1ipTrMEnCqv7R7we5hET0fwSr0VDAwYduWiNnZk1pI5y/KbkOmzKx11d
         FjFo4WV1Jqyf/1ebO/RwkowGxw8TwC7BaQLtECtz8E1MneHaTLVMR+HBJie05K+cl8RK
         Yb/A==
X-Forwarded-Encrypted: i=1; AKwUvBwUHu8sdl4IyLN9NoIt33qTZOgjjsoK7qgFJAqXl/3fE+gTnEIEw59qCPZtGHi6+37wMzM=@vger.kernel.org
X-Gm-Message-State: AFuF++kPb2vCmDTtFzJWikLTPshLmyFOzxlle3m3yBqyO49dIhp9jdRl
	4u0bK2LI6V6LJDuGSgZ/nA4rQbxfJ6WKSYi2cix+A1kSUwN8IsXCoU3Z9WB0AQ==
X-Gm-Gg: AYBFou0IwynrUCneOEFBnEV2g8tPEhp1djGvVIAEfmNU1hisJCc4N9qMzUu9AP5zIM0
	56O/1E8U9k48LB20F1E6HtfwSEyvSanJWReAIEhoQCyqPdMJfkcimEQTY1Y6L1rOBm+qyCS189s
	SGn2A0tNNEC9mGOu2as+ptfTI+o4kxBlT+sAXtuHV+4ewAGTm3YdgetplA12b9N+0UVmuwY2kjk
	grMEZdZrFAqZxTIrxq0XnnPaRPHX+XDMBzAwDW5rEhZ81z8TZO0kiEaqJKA8JK9pdrmmRvrm0Dw
	lwH5PKJYE9kHW9+i2qFmokPkmL/s5AOJ3kj1pOWJhsWyMMWxtiII8cnfRED3Euu7ZcDxwlyH7uB
	DvLn/GsSk1rbryMMTOA3RcXRy2BQqIn6KTlOxX/t//QZY7CVyGomZEK8lxegDLjs71LKVgQISxK
	agZJn62J9jI3e5lZbGoDeboKsf2PaZZgzctr5EcI/pxiTaLyAHXkVRMHwzWILGql8r3NUNZW8au
	uqZS+OYnb7agOaAJT1aExT5k9c2eclDRlpG+Yk31DOUsvO1kYjuGQ9WBe4E/bEBvfhj+hdsfOZp
	cGI=
X-Received: by 2002:a05:6a00:4398:b0:857:7337:5dba with SMTP id d2e1a72fcca58-87d1a4b3d21mr497862b3a.24.1790102772886;
        Tue, 22 Sep 2026 11:46:12 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5bfc87sm205200b3a.25.2026.09.22.11.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 18:46:11 +0000
Message-Id: <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-10-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-10-emil@etsalapatis.com>

On Tue Sep 22, 2026 at 5:20 PM UTC, Emil Tsalapatis wrote:
> The TYPE_LOCAL dynptr type is used for two different
> kinds of dynptrs in the codebase: Those that are created
> locally and backed with a memory region, and those that
> are passed as arguments to a global subprog, whose type
> is not known at verification time. The two kinds require
> different handling in certain scenarios, e.g., packet
> pointer invalidation. However, there is no current way
> to distinguish them.
>
> Add a new field, type_unknown, to bpf_reg_state's  dynptr-
> specific state. The field designates whether the dynptr
> type reported is accurate, or a placeholder for "type
> unknown". Adding an extra field to bpf_reg_state avoids
> unnecessarily splitting TYPE_LOCAL into two types, since
> they would behave identically in most cases.
>
> The change is currently non-functional. The new field is
> first used in the next commit.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/states.c          |  1 +
>  kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index be0ccad15..f57730d1d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -71,6 +71,7 @@ struct bpf_reg_state {
>  		/* For dynptr stack slots */
>  		struct {
>  			enum bpf_dynptr_type type;
> +			bool type_unknown;

why extra bool? Can it be another value in enum?

