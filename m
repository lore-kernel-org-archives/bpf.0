Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6052255F57
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519897; cv=none; b=WCbmwBcm6NjVybUDqO26XHTMeGIh+Bu5Qmu03BYhj5/kgQFB8g+OEMjebk6hcMfYOe01loRfA7EeTrLODKzaZyfcRrNrVhr5lYoCL/+x++yDn9AXu+NW7Jc1l64DsPasRc7SwK1ifgkCC0BvNZoxXr8fwDvvbY1n5Dg7MZz8AVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519897; c=relaxed/simple;
	bh=z3kOpY9ViUaUyJU3gdXhJD52Ymct6W+YUbAiOGuCXgg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HR+2Inli3RWJwAHEjiHKhXAi/8aOQG3XpkUYGHPNHsPtxd/9tMrBIzHP0yLiBAWqcqdmZ4DMzwU0DimNil/lEMcvIJtEEKndYlSfCVqt2IisiaQrDJ2PSsnzuyTlxIMxk6XeHRxc7zt47Vq02Vb5B0z98GeLWu6OtmL03lEaUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTzVZS46; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTzVZS46"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbe437b072so2604686a34.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519894; x=1779124694; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PJULk4XF26NffsCR/AJr8MgFQb7EUc2SMqGgA5Onac=;
        b=pTzVZS467mOANBa3qjwIaq90kUtDBRXa+BC1irGVPY4ZuZJ+AGso3Q8Blg9mHG1eLG
         zeI6Oa03szbQO9pMSTamoWBXf0ZwdrXzTb6zacKSoigUS+hEOX48zxGJtnYAgl1emaTF
         /74NiqpNrvLxb9R+ciasDDhRu6PkLmCaulLzuCbwR+QKDbjbSyEAYBDbsiPI594Kkdsm
         JWTxlPNBQerKJl8FWTdGPNSvJHu8hYSOSpgphEbg8cO4xLs9ZPG0uN17D+kLOrJNRmjd
         WD5nnIZitYv3fseu8shFrkqouhFDlxUnf/HzhyC6IbI4cT9Gm2GPXDlL2ffOlw7nh1ps
         aZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519894; x=1779124694;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PJULk4XF26NffsCR/AJr8MgFQb7EUc2SMqGgA5Onac=;
        b=kjwdXW4yaRPyuIjHejZ5kOjgx9/d1e2+FTbt8fE33KcMBujoKw3lMK3I9OIKl9TP2O
         YX/60hlvpivWUfV5xbY8+sgpmVuh2/PdnnYcPTj/mF63I5odJxaPaMFIttQdAwSc2OIf
         dXF1o9gZrC0exK+COmSjeJsCzaAiDngf+vtzALZ7pvHYDYJ8MBCKlRf4fcx5FKD8xchi
         PPiYpE004eg2P/osuoBwTNEYz6RP6cNSfWeFmtetBoen4g7jNMTrhLireP1sastfhMA5
         KzUrK/mX+5s+m+skrDCq5jbvLQpKLz4OVhqfeDUDU9LprP7QWahzjMdZT7JZ5jjHSSUE
         tF1A==
X-Forwarded-Encrypted: i=1; AFNElJ9dPoZwBvsW4GeIfO2GoodLf87EaMmHlrWtwyeswaVoYXYRJv+Lio0f5W45QVNKxSO71wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBg8bPsocbC1qB1wzsEVnVBE4dtPT+VO9cyL+ebQCx2RLok+e
	+TcL4SROiqlmy6IEXenJ/YI600S+2WB6NEFPX23CMI4MFh+jIosTBwuw90dXtw==
X-Gm-Gg: Acq92OE3LPf8nNvWlNicR4jjWaIhpCxFaYWEjYLoRDGVwlDEIQR2ymdTWqB7aRABaLI
	DxOZyANQ/yOB+8X7QS0ZSIy+uDO2+PmsCyi8XeR1irVWpOHSbYIJFucG8ykd54uUY1BBi0f1LEP
	S4eL87Qs5zmQ5kTr3DTp8iNmNAo/7G0HGGJjLYCMnQ2VTXLJjK446BLTm1+WkLhWCXZrxDVr1BK
	nXbhW50gtw1qjIMyMeEpCXtODdbmMasfL+frKTTY/E6dVRs3dpuWpHw1/yHzcggQ1eH2pghfxZP
	nnfMA2zzTWqX9NVgExNjfGk5fcCu/NXbMXj6IyA3+o1F2/cVRUBndvwuxOTLCMSdAjTDSpazpLM
	7nq8RCyWB6I6/1yak2RJ6TO27FKXyRL3qtwesCYFr3AP3J2j2dZ0ydQpzuc9Z2pN3/4jb72hRRL
	LfCH3hYLQj/V9YzPs1zo+4E2QAFMrtAsbXEtnfnbxHSKeEr16mcN3VH7fMVDtIKV1pdywGKfmTD
	Hc0bcciA60J3wO5qg==
X-Received: by 2002:a05:6820:161f:b0:696:1860:8baf with SMTP id 006d021491bc7-69998cc094bmr12581594eaf.20.1778519894549;
        Mon, 11 May 2026 10:18:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c9a23fsm6023546eaf.7.2026.05.11.10.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 10:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 10:18:13 -0700
Message-Id: <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
Cc: <sashiko@lists.linux.dev>, "bpf" <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from
 NMI
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox> <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo>
In-Reply-To: <agH_0MEw4b0pB11-@suesslenovo>

On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
>   [   21.604660] Call Trace:
>   [   21.604662]  <TASK>
>   [   21.604663]  dump_stack_lvl+0x5d/0x80
>   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
>   [   21.604669]  lock_acquire+0x295/0x2e0
>   [   21.604671]  ? terminate_walk+0x33/0x160
>   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
>   [   21.604679]  _raw_spin_lock+0x30/0x40
>   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
>   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
>   [   21.604686]  bpf_obj_free_fields+0x118/0x250
>   [   21.604691]  free_htab_elem+0x85/0xd0
>   [   21.604694]  htab_map_delete_elem+0x168/0x230
>   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xe=
b/0x144
>   [   21.604700]  bpf_trace_run3+0x126/0x430

that's better.
Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
but left check_and_free_fields() in free_htab_elem().

I think the fix is to remove check_and_free_fields() from ma path in free_h=
tab_elem()
and fallback to bpf_mem_alloc at map create time when map has kptrs
with dtors. Even when BPF_F_NO_PREALLOC is not specified.

Kumar,

thoughts?

