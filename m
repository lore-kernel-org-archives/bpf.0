Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6182E4247
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895071; cv=pass; b=uY1Y70pBa5+B2JFj2VIdF0nmyFX5dt0UHMiSahYQC09/cPsEdpp62ZAJMhu+2M7TcMsi+5r2OuLl9dc54cD/8vyU2bpw2Df7q1kjyrGxlKVLvX4sZTZeeZ4fft3OhVBDVXZ9OYuMTPdjCCsI4q8B4kjCaiwy6jsdjtnslBMIaLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895071; c=relaxed/simple;
	bh=IjjEjESPBoeuqWEOdgJ68RZQLoI//6qt+g/Spxhh23w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqSPV5yecfjX9cRFbbLnv+ATQgBiUPkQdOPkjQiG4fyYMoN7a41pM99WxH7wnti9vAFQjes2As86sR2CgIfCSXJYiDPQegF5fwuIyWGpSu5qU5t2oHDhxCO615lhV0/wHIqDDG9Zat11MYZ+8/PrTSnmsxIuNP0sNQdT9j9EA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2887gEU; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2887gEU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so3336752a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774895069; cv=none;
        d=google.com; s=arc-20240605;
        b=Qh/MyXseg26zROnL5Z5X94mgwfKIFZlKV00INVvvLBAibeSjVJjt75PG1qaB38dGzO
         sXurf4ZefHgbA6UduRLIAV+f1eVFv4Dy+pnEmEkRSkwz/REiIvAZQqabxasCGHBivubC
         xc9NriuqBr+dRqd0rolwrLhGxnpMy8lMsAzkXm+2720DEptQfNuuS3kHgYS05kex+x0D
         iWuI8+dDl3/nZJsvQSsGcsHBInu9LQsxOTxEmqAMsV3rmRaYL4EwiOSyjz+fCEOHv5Q1
         xSSlhWe6HIiPCXUhs8JxCtHyuFdYk/0mYMDR1BYeADQlg8lXgfdAj7fzPaRAOKyNoCrt
         bXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        fh=M42S78ZmWR0nJAKLU/RllquoXg5zbdcSUeqi8zY9Tpc=;
        b=fw1MP3sfXoJpRlOgxjL7G4YrQ6N+PjIRl2G441aTLr0BAwxkDO5PSwEvm+ZeBSLd9j
         q78lSLykso1wdf6d9D3DyAyErurIyJ721nKjBsv9lXTnU09alLC0fYDaTv41FajxT4wO
         ox9fCUZhq9UBC68cNSccXnsi5iiq5n0hz/MMZ/ILDQeS6T3EH1gJbCF/6yiLxW9QPlv1
         C1tVjl4QJMvzhLj2LHhkjRHxlXAh/9SNQC22okditZREBHTRvSozkiFNY1Zga3/+nbc4
         4DGQA7WbqgxFFmsqiIP56eyfmvmceoNpcnVs2u+PqduaqZnj8tir5Eo2vkjIaVbffg+v
         HslA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895069; x=1775499869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        b=j2887gEUc81/EX3MH8u2giM1vZgTTS/gf8kHV8yd6XehuJ4rxej68kedz00vSNJHGk
         chEajxSdUEJ8TTWW1lWv7NoMKRGToCxnR+C2nytkwgeGnAq7p1kpGjpiVflQzAjMuf/u
         1HDvEf5gQddrfvDVLqeBWZ3xZKFx0C45Gh5dblXcqQCamdLEpoW5siwjbbtzjg4qdrJD
         94QxjNB5z14kUUu83g2aT0EOCHSBUbrPnH7YboaMgv79KjeGRq5MYlRzAD+BJAB7OXCV
         ieKDVvii7O1baCpTP4Hj4YZw2pgWEIerkh/iTlAo7b7sMm1/s+M+M4YD0YJWo1dDOGz0
         zV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895069; x=1775499869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        b=loEo6x0CBwm9jRfZuQHKwm8I5kzSucoKc4mytk511ukpRGqmbbHZT9/VxjGeoj9Ilo
         ASGBOmgmnW2xmN8NBisNdI91vBpyKU44BRO+TKgSKb/BNDMpgsp12te2fDJhG4rJ15kO
         vkqPxdZZWxyOivzU85t5fDfcXad0j23xWNsjE406qB7TfOnUXzV9SiprDRGJNvRueIP2
         u3LB/tjMI3hsokVOjcrlgLbdpDlznLT8d3AcVVnUuXpFoMgYNCnkaYdngzQSXHtdHKj3
         6qnuQ+T8/PjV5tyVkj5gQfDH1UdjaPYUbLVOkMjJcDgg7tyuNmcarTTpdHGvWwaPBeu6
         yXAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5YPd7DRdorxkf9XRp8X0a441FpnN50vR1urarTJauaZ87zSijeqggfQ+dsRYuIN3XNWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHX39h5RrznTfB5hp/tNVGLwlrlLxcnLyW/gEo2YNTuUHVkz+
	2S4eXnzhDLZA33CGrTKA7ZGgQsLdfctt1N/rKoDOLTqkaFqJeQwbMxgXzaZFA0Bdr6gTmPU8BsD
	CDnA8jNQjLY4EN2fH8IXAhopCMQVJ+9M=
X-Gm-Gg: ATEYQzwr1DazSHUn/wZ+dcfrDPpNIRYfzc1jTvcwagc3FHKm1PBdA/so3kfV43JeBW2
	rPHnHoVyT+fJSWeEWdOQxUwi38rwDddiO8VVHoblN8a/chU7CaxsO42MCphjtpLoymjWFq0DGiy
	yCKEBh/gnSwcbI4KlzvPTzDpBY2vwjNbIcuUJD6kGyaLMAr72M/SKBDY8e1gO+QeOeqAlNGMRUa
	vi3I5E6foMID8xGRLt9ifYuCG8h0tlBOxNEE3fI1DSvumQhpERgVgXmeLK7ICE9kf0STlYkM+x4
	ITR3
X-Received: by 2002:a05:6402:144e:b0:66b:eb5a:36ba with SMTP id
 4fb4d7f45d1cf-66beb5a36e2mr3030460a12.0.1774895068601; Mon, 30 Mar 2026
 11:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <acp4BblnJfpVClct@boxer>
In-Reply-To: <acp4BblnJfpVClct@boxer>
From: Matteo Croce <technoboy85@gmail.com>
Date: Mon, 30 Mar 2026 20:23:51 +0200
X-Gm-Features: AQROBzCzCACh_-BLvnQFRTSbj2uJ0Jgxs7I76lfgNyafJtAFK8kadBcN3cI9nxM
Message-ID: <CAFnufp3BRyJUH0J0Q14N0sj50YjC_OqmP49gZ=z75cYER2t-pA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] e1000e: add XDP support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 30 mar 2026 alle ore 15:18 Maciej Fijalkowski
<maciej.fijalkowski@intel.com> ha scritto:
>
> On Mon, Mar 23, 2026 at 07:28:21PM +0100, Matteo Croce wrote:
> > Add XDP support to e1000e driver. First patch adds basic XDP support,
> > while the second one adds support for AF_XDP.
>
> This set has nothing to do with AF_XDP.
>

Should I mention XDP_REDIRECT instead?

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
