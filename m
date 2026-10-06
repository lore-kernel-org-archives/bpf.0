Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DA3A3830
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286735; cv=none; b=hvVruPy/iUFFoS+xL4oLne0BMSyQhdnXugqdtJRXlbXcGCpTSDuPlmBTDD6GXbt4mp2QeTdSltq2C+WvtG+NKBBCgmboCn7eIKwaoHDHWzobCjcUmkimn2tesXppahlHQxKhq9rJWw/gRF0sAkrzJJ2BooNlQY57w9F8X3YSh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286735; c=relaxed/simple;
	bh=2zOaI/Z8e1drzDVrD9ua/LHiKbHe+SYveww2HsYsFEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNGUMcw7osGnc++SRoQ71Ne0ATqWLgKxvAhfQ+SCG7K/JTA+nyGs2CxNt3UhrG9HNK+JRWCXGbRMJ7cYFGkt92/UvTskHSZC4v07rcyzFPaYb8kuyz6ZeSolyYrKiR2sT52iuzgCZ58/HcHib6cag8VdMn9lPI4im2lozinbH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6/HNBw6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1eHUttF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6/HNBw6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1eHUttF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791286733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
	b=M6/HNBw6KynajF2vBwDBrOWOgLTBJLtXwLDBNx14KOjR272PvcrMkWDzDLza5Uuitpf1Aj
	FwaaWGip5GQKlBAmQhVFYGziCHgtPZ4e/EsTlFra9veHXh7ohaUnaDFpy63UE4KThzTsrJ
	2uRYjVepto7vfz4TIl2+cYhrf5Hlh10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-zQwAwjI2PKCRyl0SSYtOIg-1; Tue, 06 Oct 2026 07:38:49 -0400
X-MC-Unique: zQwAwjI2PKCRyl0SSYtOIg-1
X-Mimecast-MFC-AGG-ID: zQwAwjI2PKCRyl0SSYtOIg_1791286729
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c54e690c5so2344742f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791286729; x=1791891529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
        b=A1eHUttFoDcYqgoVhfIK20Q9Vuo+xA9Ff7vqZXRo8wXjIubIe37wfRBHEmROVrRzfl
         prfGoNzzIkQYFFfnh8j2TpCby9kHn9n3AEJYtHKOBrFBEhs+UsW+QGjdVpVtO5xsOvSi
         VVCD85/Ue9NFOlGTbn/3NYQ0xSa1NUmCpa2H4KMTTtLLDZfwtYnKp69PtXoq/qo6SHRX
         V/wH6GHCIAxWfTgoxcDhGIxue77py+iTDP6TNW42Z+dVcefal9AXtyp+SePseVVy0w4J
         DH89k34GPJh5U3RDEMIH44b6/UJxM11TN7WwZyq0D8fi1aotjXCGzdbogAWHtPbseaXd
         qMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286729; x=1791891529;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
        b=0LEzoB+yxr9/osjVBKnDZpwn0caBkQ1G7TZ2+roTnYmecSD0r9GoEJuaipsFaE+wre
         XeZhnbnLz2YCMraa1/sx6JXeIwWM0Fgad9IBMUS8NtdTNq73ZpICQqrYWyHMumHDT5qy
         uC60oXrqfY7S3ysMSTStPkUdURY+XbM8uVis4BsnMitTrJDjumm37S38Srm+y5FiF8yj
         EvEbRgfIofXrZ/quA6F/q1JEoZXXoEPh/99Zxk026qV3l+YtelwOjfWsj19pYujIcnUr
         fHacHFhgi8FODhPXhgou0uBTDp8cXzLw+y0tB6q/9YkgUdupHCMmUbnC9g2uaSycJH/p
         C+Aw==
X-Gm-Message-State: AFuF++mv7AUUwONfnjKYLtH67ilFQuuWv2hqv9JLnGIYab6vs+DbrW7h
	ZBL/tvxX1Y7NaWeYFMi15f/qCNeaTO26f1akVnwLy9rU0vrBeezhUCypzaktJv26d7OGtfg81k9
	fidF6a1P7g1SIjkJNK91YIgzNmTlzjXddFJ1KX1P5XuZJserqg0g5Yq09JFF/sg==
X-Gm-Gg: AYBFou1P5PqZjPko3NXFzx2n3ER12MCO/EI8wugO2xyObtX1rBos1xltYtCY9x4j0HM
	LRTZN9YkU2IX7SrhhwLw1mCth73Ia3G43+xvL9966lZJ7jSI7MDAluAKttMTreoPlp5GPxC3gP5
	6kodR1hGAvgF4V/H8ejXgLAx9lcUkaDF99xfesBt/rTTTvzj35N4e2fU4IjAV8TtzuNZrSb4TXc
	lsoCwS+FOeo0p0ZV1dSY4zlsqpqL0IE+8OdTQkotA77q9DvevgpnLHioEVQyUg1wTjRONI73+Wk
	eQIoMYIMpXKympKTedJ3bPJbeB5r61oNPWQaqi4aTwmgYOjUFI5fLUCLL4DBcw==
X-Received: by 2002:a05:600c:4e45:b0:4a1:687b:8f3d with SMTP id 5b1f17b1804b1-4a17b55ad69mr16882325e9.31.1791286728721;
        Tue, 06 Oct 2026 04:38:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:4a1:687b:8f3d with SMTP id 5b1f17b1804b1-4a17b55ad69mr16882015e9.31.1791286728262;
        Tue, 06 Oct 2026 04:38:48 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm341298485e9.0.2026.10.06.04.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 04:38:47 -0700 (PDT)
Message-ID: <21e0965d-d247-49b2-86fa-041ead3d8558@redhat.com>
Date: Tue, 6 Oct 2026 13:38:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
 <20261002132815.D3A771F000FF@smtp.kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261002132815.D3A771F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/2/26 15:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: Use-After-Free in ice_setup_mc_magic_wake() during concurrent devlink reload
> --
>
> commit 6cf8b519dd4de7f3996192dbff4ffe7afc4d34f8
> Author: Petr Oros <poros@redhat.com>
>
> ice: program multicast magic wake before tearing down the main VSI
>
> This commit moves the ice_setup_mc_magic_wake() call earlier in ice_remove()
> before device structures are torn down. It fixes an issue where WoL magic
> packet wake was not set up correctly because it was being called after
> ice_deinit().
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index b121faa345c1a..857ba7d92b140 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -5465,6 +5465,8 @@ static void ice_remove(struct pci_dev *pdev)
>>   	if (!ice_is_safe_mode(pf))
>>   		ice_remove_arfs(pf);
>>   
>> +	ice_setup_mc_magic_wake(pf);
>> +
>>   	devl_lock(priv_to_devlink(pf));
> [Severity: High]
> By moving ice_setup_mc_magic_wake() outside of devl_lock(), is it exposed to
> concurrent devlink operations like reload?
>
> If a devlink reload operation executes concurrently with the driver's removal
> routine when Wake-on-LAN is enabled, the reload can call ice_unload() and
> ice_decfg_netdev(). This unregisters and frees the netdev.

A devlink reload can not run concurrently with ice_remove(). Since
commit bf6b200bc80d18 ("devlink: Acquire device lock during reload
command") the reload takes the device lock before the devlink instance
lock, and both the PCI unbind path and device_shutdown() hold that same
device lock for the whole of ice_remove().

>
> When ice_setup_mc_magic_wake() runs unprotected by the devlink lock, can it
> experience a use-after-free when attempting to read the freed netdev's MAC
> address?
>
> drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_mc_magic_wake() {
>      ...
> 	if (vsi->netdev)
> 		ether_addr_copy(mac_addr, vsi->netdev->dev_addr);
>      ...
> }
>
> Would it be safer to place the ice_setup_mc_magic_wake() call after acquiring
> the devlink lock?
No, the netdev can not go away underneath ice_setup_mc_magic_wake()
regardless of where the devlink lock is taken in ice_remove().

>
>>   	ice_dealloc_all_dynamic_ports(pf);
>>   	ice_deinit_devlink(pf);
>> @@ -5475,7 +5477,6 @@ static void ice_remove(struct pci_dev *pdev)
>>   	ice_deinit(pf);
>>   	ice_vsi_release_all(pf);
>>   
>> -	ice_setup_mc_magic_wake(pf);
>>   	ice_set_wake(pf);
>>   
>>   	ice_adapter_put(pdev);

