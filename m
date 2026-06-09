Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD842F5313
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042272; cv=none; b=UJbe09r2FIFI4vOMkBRz96spSvmmZw+3s06KPHzjBQBgy2gaGp2kmERdz/n0+78opSyNLCWNP8NghHmcuLasGE4qf1e8N8yOJQCONB95Vsrpqia085X6YRTw5g5fxKMGpsNfW/VQN7z17FmLsD7h+UTCBwfMPMVP2vN86HySXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042272; c=relaxed/simple;
	bh=yfikWMz+vWrshlwrE9kD9TpanpoD72UAXj+hPvUhS54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGdVHbCmsU7nct31NDbsMoL26frtDX+0zv+6JBKsTmOqtMH0CXJX9xkxLFY6oHZKpgkBWXr8vu/H7XXVF6nKysyeb2dG9SPp2QL2DTKnkTl+n9hmPsKiPSoKpvjZt1Cx8rHRbvvUNtpXXQZNn0pgNqKA1pEvBtmJNVV1d56WSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MdfLrajG; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MdfLrajG"
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-485ecc0f2dfso4710648b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042262; x=1781647062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+0apV/KnVoJPeQINAotVWUP54ZKhn7TmiCT4kpQxOI=;
        b=LG0r5mHifZ2OtSqhzFD8E0HQUM9iQB4DntBsUBzuoKz27YoS7lDNCUnlOWD6E2r+MR
         HzDkzO3HrSkMlN1TYNiUBKmjSiG3aWATksa3fFcp13UrALGiFi35qiv/gmBckbFJMrgs
         6h4SvNs5iog8ooObpH++28g7u8Zzt0feZo3aSz7RXociVpiLN+xd0YjwGxoNg7SqanQa
         kekY4rIrcf0G+iEGzS5uqzEigG7PvdLh0+MyIiM+zrYRv95xJmCXsdWtI+Up0iwsHHSD
         EC0v7Lwbkug6XM3ySld+g1Ax5pNBFiZ5P3jkfQEjtnwZ63xJJ/Y+g+jGiJhcdsRMyOac
         5SyA==
X-Forwarded-Encrypted: i=1; AFNElJ9k77cXt4mINtIjm94j+KL3jI8FaC61/zntrjWnhUKPZsvIiYyEFizkicmrrhyV9ib/h20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2KCWnEbgHJsXhPkHQRJFYsL+GM8tDHw1PgNF8jROaJwGmdhs
	r5vEzPXq6q8m66GSW9w8P+fR2aPgE8Z/EzB62IhGgE+Plg63jpDH3rZcQ58/9Ow305nZPVtw5UX
	DlrhQVY9pGL8yOXhML7hYHOCFINyQL3vbHixb6uGaqNiPv03ufi8LSOXfM0j7RwwWvd6zHaVjOo
	op+lZ48Ak5eeyiDuuM8thdKpLiw/2VLpdPnbJD+hfejkBe15g9AQD7tRoEaGC1LwxHiPizCr475
	43bz2s=
X-Gm-Gg: Acq92OETXz8JEKNlwoNaMFG064wZdI07v4xnYSPpVq57hQVwXy1/WMqT4C9qYA+9/I1
	Fv/kdiZb3xUBpDSVivHQvWdbpXV96mX/YVLOrPLtq7LYKoNET+9N1IMzdy1HnEEGFG6/0d87gNQ
	Zy9dlKsY8L3CZdDjLXeMA9rx7TJDVMYxovsIpe1wJjGnxxPPu0Wo3OYHjxNUvsmhlHcpl8f8MnE
	XmOFBd41e56pfoKRrrea3PPxNc319yvBi0UEk5Y9s4P8dwi8pzkwdaH0frfYtKRVJ7cH0s1FMmY
	YLLfMT0CY5TjYjjYsj+BtAnjl+bwwGqFVaZ0qhokVK4GrkTljzXh4Fox0nV2k8JSI1PE0PuQZ/1
	2VCUKYvDoCiPwHuaVVCoDENC30Y0W6oWazzqnXsVzITHZMXX5qSAgM+sT/8r4j99GtINBzRD1eB
	ysmGtONE2+tpBc95wVcF4oNiTupbAIdTUH3foR/eRoBBSDPtGSV1dQ5/uu88PHDNmaUJE=
X-Received: by 2002:a05:6808:251a:b0:46a:c98c:bfe9 with SMTP id 5614622812f47-4868df08898mr14458040b6e.40.1781042262178;
        Tue, 09 Jun 2026 14:57:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-440d8609231sm1929938fac.12.2026.06.09.14.57.41
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:57:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bf2dfdc0582so476301966b.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781042260; x=1781647060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m+0apV/KnVoJPeQINAotVWUP54ZKhn7TmiCT4kpQxOI=;
        b=MdfLrajGTNmKRQBa0Ge05pLGYAL1oimPqyNOW+OFbWtBWi9TZ8nm9UjueiVxc4GbCy
         wV3Zpt2/eF7XoitR3NqYbW7T5kvRjNyt13tPESmsfjibOgnBK1q6ls2OaymJPJ6MM47P
         AfPujTxrgXtO0Oh8l9RDYxesIeqJZJxzUQefk=
X-Forwarded-Encrypted: i=1; AFNElJ+VYK1hgLvAHq+ZaXLL3251O015ZiJio2D5NvvmD/NMaHAytQp/cS5CkS93042YGUt1hAU=@vger.kernel.org
X-Received: by 2002:a17:907:78e:b0:bf0:701e:b148 with SMTP id a640c23a62f3a-bf3721590cfmr1125279166b.27.1781042260332;
        Tue, 09 Jun 2026 14:57:40 -0700 (PDT)
X-Received: by 2002:a17:907:78e:b0:bf0:701e:b148 with SMTP id
 a640c23a62f3a-bf3721590cfmr1125277966b.27.1781042259784; Tue, 09 Jun 2026
 14:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609204458.2237787-2-joe@dama.to>
In-Reply-To: <20260609204458.2237787-2-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 9 Jun 2026 14:57:27 -0700
X-Gm-Features: AVVi8CevSJ802s9G5faENZmG6K0AzNibyZVOPZrGQQlAcozOjlqEaPjmVlYSPhc
Message-ID: <CACKFLikfZ5YeC08YsQPi7Jsaxd3j8nWVZ+6C6bHeEDcQhp4yeg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, horms@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000047a12f0653d93726"

--00000000000047a12f0653d93726
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:45=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
> a bnxt machine (and also crashes in NIPA).
>
> It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
> builds the skb head:
>
>   napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
>
> The problem with this expression is that in page mode, rx_offset is:
>
>   bp->rx_offset =3D NET_IP_ALIGN + XDP_PACKET_HEADROOM;
>
> Which evaluates (at least on x86_64) to 258.
>
> The test test_xdp_native_adjst_head_grow_data tests a case where the
> head is adjusted by -256.
>
> When this test runs, data_ptr is shifted to frag_start + 2 (where
> frag_start =3D page_address(page) + offset).
>
> Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
> expression subtracts 258, landing at an address before frag_start. This
> could be either the previous fragment or the previous physical page when
> the offset is < 256 (e.g. if the fragment started at offset 0).
>
> When the skb is freed, the page pool fragment reference is dropped on
> either the wrong page or the wrong frag of the right page. In either
> case, the corrupted reference count can lead to the page being
> prematurely recycled while still in use. Once (incorrectly) recycled, it
> can be handed out again and on driver teardown this would result in a
> double free.
>
> The commit under fixes updated this code to handle the case where the
> native page size is >=3D 64k, but it unintentionally broke the head grow
> case.
>
> To fix this, add an offset field to struct bnxt_sw_rx_bd, mirroring the
> existing offset field in struct bnxt_sw_rx_agg_bd. Populate it on
> allocation and preserve it on reuse.
>
> In bnxt_rx_multi_page_skb, use the newly added offset field to compute
> the fragment start and pass that to napi_build_skb. Adjust the layout
> with skb_reserve.
>
> There are two cases, the non-adjustment case and the adjustment case.
>
> In both cases, the skb is built at page_address(page) + offset to
> account for the case where the native page size >=3D 64K and skb_reserve
> is called with data_ptr - (page_address(page) + offset). That
> difference equals bp->rx_offset when data_ptr was not moved, or
> bp->rx_offset + xdp_adjust when XDP adjusted the head.
>
> Re-running the failing test with this commit applied causes the test to
> run successfully to completion.
>
> The other rx_skb_func implementations don't have this issue.
>
> Fixes: f6974b4c2d8e ("bnxt_en: Fix page pool logic for page size >=3D 64K=
")
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

As a side note, struct bnxt_tpa_info is similar to struct
bnxt_sw_rx_bd, but it doesn't require the offset field because we
always allocate frags for TPA.  Thanks.

--00000000000047a12f0653d93726
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMZh03KTi4m/vsqWZxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDk1NloXDTI3MDYyMTEzNDk1NlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMEQ2hhbjEQMA4GA1UEKhMHTWljaGFlbDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AKkz4mIH6ZNbrDUlrqM0H0NE6zHUgmbgNWPEYa5BWtS4f4fvWkb+cmAlD+3OIpq0NlrhapVR2ENf
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCkk+Hn
tJaz9zXipm2RqwNLMqxfYf21n9Urq44CQMyOUjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MDkyMTU3NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/k3qMpgqjiuBOBLFgIO81BcHXRL1spqHFGWengj/X
amNMtv9J0Y1DaT9fCgqfH+dykLDfYiMG9rgoLAZf+mXlHy1qXZw7VyrmQXuG3z4axPVLanTbrBUc
40iu7DMhqhZ2f3n5IsQoIrkJmLpd2yjTr7oG0Ol6Ui8Xn9WZZpfIzcfdBB7Uw+vXJUYV1+gF2YDZ
URhuKwJ3nI/If4RBo0DHG48F016A9z6l2MKVG8LFrId1bWGfO1NZthE9UhIzokuKETzJ2/rRGsVy
1ELLX+7HAy/YvEloxsPsk+ZY94dcw/4GQIxWxEANXzHln1a09AIs/SjwzYf7D+D7jqrbUVUf
--00000000000047a12f0653d93726--
