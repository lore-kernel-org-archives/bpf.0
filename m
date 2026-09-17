Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3C33F8B4
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656498; cv=none; b=p7yqZZ4pjpiw2SWCjFrZknZ//HTj1mpNV1Qk5lpgoZaqbKOTySyHoufC1ELeqoiF4q0i6NTgz49PcnHOnS+efqOXC14nmre2lC74bjdNo6hvqLiqDdwIZsIseajONQsdC923e8ttkkJWEfpx80weZquz9uI4nyeRRhnLcC+IXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656498; c=relaxed/simple;
	bh=TlDhzyajRA5f0zub5bwxnjG10gWnL8OjabF1BPRCS5o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=YBagrkYXiCavBCkWBtzFfbA8DAp0wqxE3mOJSiAfOmpmnT+YuA4IBnbYGAYEVSNRPM2JGUl/qs6bVGohf4a0q4B6ue+K6O2M/XJHbsO4htIkV7VWLAVBJYWHqpJv36lGiSkWXTauE7aVMBU29ZBmoTF5sdRf/PJrDRhEvlrBIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQCd+MGF; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQCd+MGF"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so1380827a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656487; x=1790261287; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wn5NsxyOXQcOb7sV/UCodhNpDSo8VYH5Qa/WX4wiN4Q=;
        b=ZQCd+MGFecTWR21nqgMaVSI8cjprbLsukfI5YmU99Akz/PAH3jJj3LsnGUcLZsyZt2
         9BK0Yj5TyA4HiDBM3W61iRofDa8CiHcV7sMQWCdsadtWzZHV7FIAkIpy8C2WOmWJU3Pa
         PsQFWICGK9+zvTijy5ZZ5waXWoCb57cy2PBy73vfjU9uUyLgOE8Ryn5hKayEDA1q4Ts4
         vMcFXLBhhjxkVHXAOQz8+OjCGnTdb6MeDUJ8QylT+JqSMoSEol09h+FxmNiQlbuk1+YF
         G5A0CoVZxjvR/G+vc9HItFRBon2CMpxiro3CILw2lIunV5vm947bSE4+TX4v7t3Ma0F5
         CUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656487; x=1790261287;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wn5NsxyOXQcOb7sV/UCodhNpDSo8VYH5Qa/WX4wiN4Q=;
        b=Gc+moZ6TbvKlU2J89sfiJa7D3zc6hdfdtVSoRQYGHacA/5lo6AdkTVopHKodNCVqlB
         MbYkHUNzj1pUhezjgRuewkuTvRE0EH3dc2JJIc8K9BKfO5hltyCZwiDFJiAviCnHdEH2
         AWYUXM7gEiAhEXGKPoRgxLG98+f1qCYBeOhP9SQOGHBmSTwsutO9WlFW8byqE28q6NaK
         3vz3oioenixkCMQA+qsN3ZUYxSmVp0MmAEwHnotNTQIh9IP079216Ybw92CMxJFzK1At
         HXzCgF3V0B7MUfWNWjMwr+spTr7+17LdISgxErc1x1DwJGv2RsVCjAyT/j3WYssHOt7D
         3LkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1Ak22OqYNE57ObpLv8fnVdsB7Z8kQld4RicREvnY6t542OsdEPTqF8j7j6aJc6Zl74Kc=@vger.kernel.org
X-Gm-Message-State: AFuF++moqs4apKfcfSF2m4RME9J0kRU4CvTA9gKxSRMobC8AeED2gcFR
	UlP3CUwfH9rFUVEUb1F7ks6QnIxcbwzYpQN1tdllJ+ZsVy8bjm94nCPh
X-Gm-Gg: AYBFou00c4b5n+bpm3M9zbKn9ES3uEv0R34exBZq6IyON1hK4tOVBa8uucdaS5UY/CR
	79swziy7nReG3HcmYd65cbB/uAYx4LJSJnHIufb0PJnlN8sOVUbmJeetiE7AyaSc4BZPPji/oqh
	ptAaXsoyx/HHVfTYJoWYFUgy9BLDmHhAtrTB2SDHRymZ6GgKteekrYXb2i70L5xgaL3bq9RjVbA
	GHHiZlfnGqbVCmbBFWWbI0l7kWkcWtFiRM8n0kvaf7pvetdv7Quu+CG6D+aQ/+JaDaQ9GeNw5GX
	5TrcN+WwVhoRM3idWgsuTXIScYggoqRmweBglocqV+p61SjoYA+CA6QhpABcP2xzgu57NA/9Rz3
	KRttb5rBRCKfTPCT8J406IBuq9ZxwyvPPFk30XLipj/V0JiuAuBbSbTj51w6X3lmzlhbHHfQLAp
	dhPlSGxwI4VodL1YY8R/BCLb+CqmNnyTAyeTPv7V4eOhMvbaYr4bdEJ617QxL1ydQwYCwiwscmA
	AL5k8GscD1+PKsNNE1IHaB7PbzU5+aYi/n/CE6ng2oiozuusY1rbyIOtaGtcHpxt4Ir9JjFbj4W
	QGMg
X-Received: by 2002:a05:6402:455a:b0:6aa:4b1:8a99 with SMTP id 4fb4d7f45d1cf-6aa22453dd2mr4655355a12.41.1789656487041;
        Thu, 17 Sep 2026 07:48:07 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d228bccsm3886836a12.7.2026.09.17.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 07:48:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 14:48:02 +0000
Message-Id: <DLHO9Y7TLIK7.HLZOCWK5B3I8@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
In-Reply-To: <20260917052000.1589643-2-xyx2021@mail.ustc.edu.cn>
References: <20260917052000.1589643-1-xyx2021@mail.ustc.edu.cn> <20260917052000.1589643-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 01:19 PM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:

>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> -				        struct bpf_func_state *state, int spi)
> +					struct bpf_func_state *state, int spi,
> +					bool on_func_exit)
>  {
>  	int err = 0;
>
> @@ -867,6 +894,15 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  	 */
>  	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
>  	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
> +		if (on_func_exit) {
> +			verbose(env, "cannot return with referenced dynptr in callee stack\n");
> +			bpf_diag_res(env, env->insn_idx,
> +				     "referenced dynptr on function return",
> +				     "The departing stack frame contains the last dynptr that can release a referenced resource.",
> +				     "Release the referenced resource before returning from this function.");
> +			return -EINVAL;
> +		}

Pls
 don't add a bool to destroy_if_dynptr_stack_slot() and touch all of
its callers just to print a different message.

pw-bot: cr
