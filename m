Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36504E50C0
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584119; cv=none; b=AzNu5v6YNePN/Edyr5ayCLKFvIpgEEk6gEFjsYPTuencKq+HdMs3V8FWokwb3OBL/n4lWfySUcuJD4OblCwLYg0YOTO3VPOek7351Lg3BaxRNj/LHv6UXJOZZHezW4TIfYAujqwJU+/qKlyWpNYs+zPVDH9EMOjCsXmRpXvCcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584119; c=relaxed/simple;
	bh=3fViUkPJ5R4pqZ4tsyhRvt8PHfD5g5yJFO+soEWsKIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k3RYjNgTF2gwbbQaraOlOUWXL+d73SYJ0o9c1en5n/hk8Zr0FjUaCU3De7PfxtZLRDcmqf+/bsX8ugrLIZQSH0OJXmn2AH79JuBqwVagUdG+i/6IZ6m76ldOMa8kjDrIONFQDNnZTbx2/qdPISDHh07GAzBArTmAqDh+kUNx5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Z1IXNTSg; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Z1IXNTSg"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1463413b3a.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789584098; x=1790188898; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a1HEw2KiY0p3aEPTqA+U7w///uMWZ5JDbZz23TPVtOE=;
        b=Z1IXNTSgvpmi14myJGQ5yl34mVcGrjzKZAwg+6QpSbUNbksgi9kIfzs4IbXD7QX3lD
         n5e4rjIZ5xXcGUrfLUNlQVl+wFuuoHH13Xg7sWXeqJhL6Z57cTDU9QBHchclQg1gaTN7
         x7BWQYH8uS+lJWYvM1+rRdW6EslYQEFFStpc3xocFXvHKiqd+M7oVylre2PNL12r4SSp
         EoHcGjQSfj+v4689U8lsFBIEnAXt8USW8SN26xGTo6kJNqPCTb7JTg/ac8I1E0PG7Y2j
         c1h58QJd7eersMvekBpak21HAJgtLOCtDSFy5VgY6+gUSQ9joSnRd3n575NqJv0bcm6i
         lMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584098; x=1790188898;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1HEw2KiY0p3aEPTqA+U7w///uMWZ5JDbZz23TPVtOE=;
        b=CDyyzYwE3NhMQExoA2SWPLcEn0lOqYpb44QRTy/a6wi4ga+OoBLhbNBmFvYaxiA8o3
         WJoINo9T5RjQR7pZIkmqJIsx3LYspUvvAe0dtJgqpcCVCugzt7Hn4YNDVawfFiMebGuz
         aZcybxjlLE4UOFE1NyLDBsZXXKxlRkqZGei8XehEo5vwObAB+ETz0T28uCTvHHpCyond
         S/X3Z16zWUHLNeiheo2Hd3i6UGqIPunmiEGGzs04GWYKeWbV/Ft91YI81/kr6CcKM8Yp
         Humfvjpd9sRjqcFpOaLaedVs2UrcP7KD83uu/H40tWvkQeLuz3p1+bv/Ejg4+2Bnp7qk
         iW1A==
X-Gm-Message-State: AFuF++m+1SqmyzusSdLrBXzZRHzmGINLVe5ysjvT/fGr1HOV2Lp8alts
	rakzrRupyhuIVfFO2CGvWxK94ZYyU4n9GA+yLfKOf/LeqDNi4Coi2guuOXoVmfP8Wf8=
X-Gm-Gg: AYBFou3pGej33/Pf6tzFpFYUkp6uUj+Ul55BMV+zd9ERG18SWXkhMvRR1qrKWZQMy9c
	EJKEscUOCnz648wSWpM14cwvl/K4+7wnvz4W8YXfCkrm3wM5GOVA116unb9+aImGN5EYEZejIeo
	qxd/jYXDkBtme0ql8ixLGpOjePEGu4YC0VrRzb5uPcFHOndPADQX9BntYobuyKTOQ8meau27BwA
	D+jmXw9TuqvW4fdT5+/NDkldZCLbn2f3q4dzhhR5+E9SB0qh4cFBaluLRhVY42jRZNfhqG2nHGq
	UdWUpiYa78XBxQ3I9LRg9Q2qpTfh9xuqFg4hHZPJFJy59DcGfU8l+DBJV5SwcPlU16BxqHqsX5s
	CyW6ok6HPPdl6P4aHXdu/3actArvsNTzMZhTrehrH/HjWjNLKZtzIJ5WSbBHQVAr/yZEUp3rIzj
	X+aIgC7EdQ8n/GzfnXdpTJ432JfqzsKxzzT8ChLZZG7dS+i1AzjGJKB5S70d1RK7NL5Q8XftaQK
	kRB4UQlB4hFUQeYQK+6C9zJAprI
X-Received: by 2002:a05:6a21:6b05:b0:3d0:8abe:9e08 with SMTP id adf61e73a8af0-3dd5f4066e7mr10329013637.3.1789584098119;
        Wed, 16 Sep 2026 11:41:38 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50abb30a3sm2029801a12.28.2026.09.16.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 18:41:36 +0000
Message-Id: <DLGYM8KB90NB.1X7S5GYGB1MWJ@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 09/11] bpf: Track whether dynptr type is known
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-10-emil@etsalapatis.com>
 <20260916052228.CFE9F1F000FF@smtp.kernel.org>
In-Reply-To: <20260916052228.CFE9F1F000FF@smtp.kernel.org>

On Wed Sep 16, 2026 at 5:22 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: missing type_unknown check in stacksafe() allows unsafe pru=
ning
> --
>
> commit 8f00e7cb51fcf9e4513f3c3e9be943021ba739cf
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> bpf: Track whether dynptr type is known
>
> This commit adds a type_unknown field to struct bpf_reg_state's dynptr
> state to distinguish locally created dynptrs from global subprog argument=
s.
> It updates the verifier to set this flag, preparing for proper invalidati=
on
> of unknown dynptrs in subsequent commits.
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index d5b4ab0bacd35..76aa724de1bcb 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -71,6 +71,7 @@ struct bpf_reg_state {
>>  		/* For dynptr stack slots */
>>  		struct {
>>  			enum bpf_dynptr_type type;
>> +			bool type_unknown;
>
> [Severity: High]
> Does this new field also need to be checked in stacksafe() when comparing
> states?
>
> Looking at stacksafe() in kernel/bpf/states.c, the STACK_DYNPTR case comp=
ares
> type, first_slot, id, and parent_id, but it omits the new type_unknown fi=
eld:
>
> kernel/bpf/states.c:stacksafe() {
>     ...
> 		case STACK_DYNPTR:
> 			old_reg =3D &old->stack[spi].spilled_ptr;
> 			cur_reg =3D &cur->stack[spi].spilled_ptr;
> 			if (old_reg->dynptr.type !=3D cur_reg->dynptr.type ||
> 			    old_reg->dynptr.first_slot !=3D cur_reg->dynptr.first_slot ||
> 			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
> 			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
> 				return false;
> 			break;
>     ...
> }
>
> If a BPF program conditionally spills a locally created dynptr
> (type_unknown=3Dfalse) or an unknown argument dynptr (type_unknown=3Dtrue=
) to
> the same stack slot, could the verifier incorrectly treat the states as
> equivalent and prune the unknown dynptr path? This might allow bypassing
> the packet pointer invalidation logic when writing to unknown dynptrs,
> potentially leading to a use-after-free of packet pointers.

Bot is right, will update accordingly.

>
>>  			/* A dynptr is 16 bytes so it takes up 2 stack slots.
>>  			 * We need to track which slot is the first slot
>>  			 * to protect against cases where the user may try to

