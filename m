Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7C23E330
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710551; cv=pass; b=Xxwo03EiRqwcbPW3EGGkNJsa/N4MloVC9KE1q0naB1CvqQy5WxHn1A/QZryFKcXDLlAdfavIIqZySuCM+PtZUJvddhj46XRwxEaGde+mEATajYFIrZpX7N1rXy/gvqFa2+bNxZ1hkmZp5JnKAPWPr3+VZmi0a8/DkctpK3D33KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710551; c=relaxed/simple;
	bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG0sV1aOr2OaPaGdn7+keHjKTE3GLMyazZBUdQc4LxUSqVjrDcKTGQiNzqcckemiPwlR4fZ0pRDr31be7nNsnDo3oB864oMKp9KuYf+GtH0vbl6tM+7TdYZorsXK6mqregw9KVlMQv9e8F7Oz1i1+pTlHnuGo5AWg0ffhb47MME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmVUjtfE; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmVUjtfE"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bea8a1c040so3165210eec.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773710549; cv=none;
        d=google.com; s=arc-20240605;
        b=FnWtcL9XE/H+6HWjCipcIvhZPuWpX9x3f1so5SlkyepwAsUemkRrozgPKV/iCr33vY
         /K++xxhEpp9cL0jkrUFAci4JtFLFrqL28aFcpKUeVteVyiOltIQHolL8flYMp7xeRi12
         D13uOCyjpwFfomPxzSaPZix7gNRko1ca196hWaM3Rg4j0BkobHbMRLDm0Supa84F9dm/
         4MhUUiYsidTr/XKJr7fvm+PvbIcVrDJs9SLb858dp2FLnqfzK23BI32TSaxyOzIiyKfd
         +lmSY80qO/Ri46Y7BVCPjduLIhVi43Gk6uGyMvpgvkQsG3+35abLIag4HRBoiQsgeFvy
         A4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        fh=jKcuCDp5HLb0IDQ+m4gsqlEvQNfIYrKlF9JpCB7KCwk=;
        b=edgtm4r0uBI3DsbZVYLg6G8TO51jCke2FzMTOTKjWnfErp1SfOYbmy804U8CLQgk0z
         e6wO4U+DVqEYqjRl7Dz/Z1rK7Kp9TOmLrZoy5MKjDQ3rpLwSVD2kmQCcVE3wdXkFgDp+
         kpoFPZPavOmS2Qmmq0CKxG0i0VxGjW93uMFoJ755wTMbt5kijZabmCLF4x+xwESAnUup
         4Phg/lYZCJ1onnsaC68kD51D5oC/kNJRNWAikImiFgb7GaYou1z57HpoAlSIMf11hPSk
         tzcXKjpy+tn+i4/7RylsIIpZL4HWZ0rOKjQGPn7wtWR+/QZYmymPDTLm71C/vF8MTI6y
         M7KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710549; x=1774315349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        b=gmVUjtfEwGzK7O2Hfo4Zl++8LWLn5Mc4o8sg2b1SpglAG82l1ALu6ZnNzJpCQ27Mv0
         z9i9S94Z6oEF8JieGybkSgkx/tJJDZAnXbXg1PZfBCODHEYeLvphUCoZt3jRleexdNhq
         hJr1Ch0KjA3vhakSWSgGeKZuF/Jx/s2b482SRXnjpQsdNDiN9OjMGBWdw4uWFOlCmyvJ
         yIZ5fH/voL3tBYeZ/G2bLfJjCGxIE7FmKh18U4799lum07A+83epcgnE8G0yPDDdrWbl
         +C997jMbLyPgUzJKTpCy/+/aWapdMfv9MxokZuDW/97XOUezQV5sn4vnP+eR33XOCiIE
         toxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710549; x=1774315349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        b=YIZS+oopH2hJ8pfd2dwxsFTJAn+4oIjoCVnpsTsMivKFXyr3aVxCicaCuT8YAzDl1O
         M49IvmXgbb9UmHAFJnagucnEaqJyDPKMsV2WpfJSJLewKxmUKgvrhO5YvlJkmGXjafK5
         Xtm4hFdVGesCRluf3NTbRZQVwnO6SwfNG+m8QPz7B/vEMUAcyqSdarxAX1V1TaM4Yyss
         ZHGcT1vXdnRwIDine7lU3/b3zW4w42LKSDPF8B81FyL3p9O8klrl2hEWWa41cn8bnyI/
         xdL/tt+7Kul7rW4U2tSGESlQgNB5NC86GrF5fJb39EdW4HMcD2OdULWpJ2TS6CyRV6Ys
         IK2Q==
X-Gm-Message-State: AOJu0Yz4FHWH32jdShiKAyomdZpXkwzw9FoG3aUC6t1GK0sH3ov21u3W
	PcZ/QsCC66/z2PniMsFgIXSqPjULjpB2r0DuwqCyNNmR97tBENEJISNVFO4BzPVj09V4MGjLld0
	V7Gxu2lVjkWqwPKsCWHwVG6ZeAYY68O8=
X-Gm-Gg: ATEYQzyxFr3zek5ZsgS5ccB37hM/3l+9/RZiSJJKEPsfg4mwh52bc/q4TAweYhrRqLB
	NHQDaEdU9AgPDqq1DCxeFmqmV1srR3s2cbc/UFGCMPIgqdqTohb0ZL37G0koen6C3zz1VJe7zWz
	VaI14bUrB68T0E+gUpwYYGF2yY2kq3nHIesf1LelSIigkn6hB3CJQizC5ZHa7nCdkVKEZz1Txxf
	lswfNk/CaZgAsn7a03+H/MyNBPv8bqg+D6MUUEjgdiMFj/0GF4cIJt+FfUEm/aI8ZNtXKp4UHlZ
	cXD3N8A=
X-Received: by 2002:a05:7301:1695:b0:2c0:d04c:a6a6 with SMTP id
 5a478bee46e88-2c0d04cad22mr1390815eec.6.1773710548997; Mon, 16 Mar 2026
 18:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 17 Mar 2026 09:21:43 +0800
X-Gm-Features: AaiRm52DH5oXYk28FV_vIJOaFFEWo_W567s_FD9sQhe7xRrBOElIspH24hS3Uhw
Message-ID: <CAL+tcoDHaWXH-cN8hSAs6S_U7xfD5k+OdoAfKmYGeLaGGJLnYg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:14=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
>
> Adjust ZC path to follow the same principle.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
