Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DC3AE6FA
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251047; cv=none; b=knNiCHsbZmQhlWSDEilz4VDNu02feBeUkdsZaj0R9tqMQz/5EPc/CC6pmPXp8ZhiknG39DxbNDlBruDsLuO2/TjHaENxE+vMLuYMU3ynTFqjhDRF6YDTMeMLhItrFEYWc0pKbHoQMbPFcpW6jqybFintsJaJv2fdcBEB6xdCWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251047; c=relaxed/simple;
	bh=6Qsy2M7+l2Af0UGKG0/U0FTuq7ast2zlW4MiZr71tkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BDB2K/dhrCDKeYtXSZuaysTFmmwzOozpzDTa5ILPeq2P7FQgA5xOUslN0qPaZEI8st/dnYRJfRDQZrzVMybuJ3SxwiuGKLatJJLawTmkDD21IUg9xutsuuLWI9rBcg6OtpmWmHqHPxq1fU31cmhKpguTLoasi1xrHbiB40/qDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HyiNEbPj; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HyiNEbPj"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139b914bab6so411062c88.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782251045; x=1782855845; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VE1ARjSQtvuoqvl602wN1xGAeSbqj9g2cxuv4HM874=;
        b=HyiNEbPjY70tzN0sr5xXpDU+/a3MRAdhM+OIX4ZUWjyU6NUOl6ej/gtrdy2RLd7lTV
         D/BLnXhUdPI/FQ4IMePVwz36Ovom3RmQludVpaIeA3nmRzqaWIwH8E04PNoTxCYrMFsh
         Hmn7lPj+/g6qIPCQ2u2NK1ziQ71A087v+VfADgJ/A99/es3ZNTDS/4JJ1IuqsHcncoQc
         m9ExA3s+0OiUGnfqFj3XcFuz4nhaKejIrkWCRWZ0eH8OEkgMMzgzwLRUkKuMIkcQkZ2/
         wGX0uvlg38Xgt1wDwk+X2ORx4C+jX33AkNuDPvflcOoDSgTzOTRLADYFBqhujdAHaxGT
         irqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782251045; x=1782855845;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VE1ARjSQtvuoqvl602wN1xGAeSbqj9g2cxuv4HM874=;
        b=dtJRxQObsksIcwXwhOKhR3LrY66wnSMa+8hcku65zp+D1vH2eLu2yy/Wf6rzgnqzFQ
         T4Tu73ko8+I3FweTrPPQ747Z0XgWmFHFkpPlipxAHjs/3lAMZot0bue2TDC0j1LHFke3
         1uyCfUbUntZAy11O0lUPaPsLEdVBJTxJZAT8KBaPe7kZum/xubSWqA+ux6X6XF4bkr1g
         L6EcqlSIbrCJ89dSX7DmWS0OlKuPIkThNKXbcgZ2uD0bht24HSWiw+WTbwuLwPB9KP4l
         lb1m4HCzRykjhqyJSBtIY/KNmRmgaa6wceXRaO+KQJTaUlxRTccVLbQ3kh0s2z+14PV/
         Zuvg==
X-Forwarded-Encrypted: i=1; AFNElJ+3oxvZ0vbtQw2DCCikpdmYbUMSOoknd96AVvoY1GQsQTY/UaqLcPJaV3gyF9hryT5vvIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sqgJrv3y8UcipTwlRhzGMj4MiBKVUiKUVFr9rfqzHxa9oyWb
	H8525SnTu2EZ6aAfTIt2nPslmIyCts8lg8Dy7fDsdMBC9Qk3XDh0U9KI6wETRqCw7Vo=
X-Gm-Gg: AfdE7cmhU6t6xaTeNt5uUFIpwaiuysObuhwixI95hny6tcZAzSuE1YB64MmCAsIiiRW
	Xoq3qPaxOeP3wIJyUsoW1EPbRYlWFO/tDSCLW+6hgXRScU08tfu8EOVlZvcnSRvYC9rDfoD4HHo
	SeLMjwiM1I83XFZrpFUAo4xeZB8zW+RcjrHGPdqpkQ3V70khkur6pHJHanoWu9JMpVlchRSQDHn
	3cldjit83GuXrcnh3U7CPR1SnXJGSozvn1rpIrgRQQp/oZdonSnp/eEc9oyH1akfpKKOQg+udQj
	kmVjBo5aHKDyfbpV7AFRv1qwaHPIQgPJT83S666Jh6L+cajLc3xk33NyB5ebwpka3ptPnqwRZbV
	BMZai9aUhYIV5fjbluQJ8e1SuLwxStx8jdV0/jGhqqfcLIzPEyesKiGveCnchyU7PHg04jA==
X-Received: by 2002:a05:7022:f9e:b0:138:4067:e44b with SMTP id a92af1059eb24-139d0c04109mr481688c88.12.1782251044946;
        Tue, 23 Jun 2026 14:44:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm15526848c88.12.2026.06.23.14.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:44:02 -0400
Message-Id: <DJGR9M02WSP5.2SJ91UABVUWAQ@etsalapatis.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map
 commands
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yichong Chen" <chenyichong@uniontech.com>, <qmo@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
 <E2D0E58A0333B7F3+20260623072220.1421837-2-chenyichong@uniontech.com>
In-Reply-To: <E2D0E58A0333B7F3+20260623072220.1421837-2-chenyichong@uniontech.com>

On Tue Jun 23, 2026 at 3:22 AM EDT, Yichong Chen wrote:
> get_map_kv_btf() caches the vmlinux BTF object when a map uses
> btf_vmlinux_value_type_id. map dump released that object when the
> command completed, but left the global pointer stale.
>
> The same cached object can also be returned to print_key_value(), which
> freed it directly. That leaves btf_vmlinux dangling before the command
> cleanup path runs.
>
> Use free_map_kv_btf() for per-entry cleanup, and reset the cached
> btf_vmlinux pointer when the map command releases the object. This keeps
> batch mode from reusing a freed BTF object.
>
> Fixes: 4e1ea33292ff ("bpftool: Support dumping a map with btf_vmlinux_val=
ue_type_id")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  tools/bpf/bpftool/map.c | 12 +++++++++---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 7ebf7dbcfba4..a265ad3afbb0 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
> =20
>  static struct btf *btf_vmlinux;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +}
> +
>  static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **=
btf)
>  {
>  	int err =3D 0;
> @@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
>  		close(fds[i]);
>  exit_free:
>  	free(fds);
> -	btf__free(btf_vmlinux);
> +	free_btf_vmlinux();
>  	return err;
>  }
> =20
> @@ -1049,7 +1055,7 @@ static void print_key_value(struct bpf_map_info *in=
fo, void *key,
>  		btf_wtr =3D get_btf_writer();
>  		if (!btf_wtr) {
>  			p_info("failed to create json writer for btf. falling back to plain o=
utput");
> -			btf__free(btf);
> +			free_map_kv_btf(btf);
>  			btf =3D NULL;
>  			print_entry_plain(info, key, value);
>  		} else {
> @@ -1065,7 +1071,7 @@ static void print_key_value(struct bpf_map_info *in=
fo, void *key,
>  	} else {
>  		print_entry_plain(info, key, value);
>  	}
> -	btf__free(btf);
> +	free_map_kv_btf(btf);
>  }
> =20
>  static int do_lookup(int argc, char **argv)

