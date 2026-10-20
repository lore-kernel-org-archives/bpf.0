Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513398;
	b=pFlHpFzUcaTiE3jLW0FjBuTio2o71COa9PGgIOQymAmuNJ4bzVrYBz5Hr2xWsAZqyrjN
	 HMhBGwcNzjoeZOr9KKSM0vuV3jz3+o0e0V3+dOgSfiIBVrJhauqn3FWkODOYgKfS4EpR8
	 m/LoWqlqsKjvqfvrdqgdxWyxJRzZif8zMmY01UILV/CLX23ATw7W5/P4gYLSDZCcS/llc
	 qQHVxr0iXDE1uF1t4Qsp63URFkAKU1hdGT+HNnMlO4cixTbqCduWQJ3OWZ7ZwWZ653TtM
	 BfcOtjjSm+5+Ko/xBwvtq58sLBmPB4zL3dsZuiJvHQ92HirtzFL0/9fdILLDyQ0BmOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
	b=eeKsK/aT3H1I4Cnum7jAifZKIWgHZ7vbE/WtfzDHmRZnHtdg9W0dD2pLifPTjTQXL9Os
	 2p0NsMT1BWB8cxw7gRGK3C1WVT4QHAnyfPkeFEEh15b07TG7COJRf67nTbAEDLLR1jf2R
	 w9pqQY4Ib88s2ze77tnDWy1htJWYMJg3QyZPiJfvi10xE5Qn5BMHeQ1j9G/ex4jYrF/d9
	 pc6c4WT6SKwP4+pmL10ubZbY041iSY7BvZLicRprijBzM9NMnV0DkbmJEC8BrIOszkikP
	 Q1Y4+3UoKYJUuciWKIl/dFAl7t5yQ7gQj/n+TIxC6gOOb/RBrPfWraMlH1NG3iY1ulw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xua+F94x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B9606A31F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F09B9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xua+F94x
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so14913a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513396; cv=none;
        d=google.com; s=arc-20260327;
        b=mCIm1YwaZzn9/da5qTpl8MOqlWNqCMM3np7uRSJW/5yOLvFiHo5UcdGuLpcHDNTRHB
         rY+8bj7SorF2ef8JocHthMSi5xkJ6PdQxZaltB67TfGSkEzF/Khl6JzfOfsIvcCkALy4
         Ne8VCkF61SOCMXJofk6Psgi7YMSFMcRvA3KUCPpLKZoKuxZ7CNkkWxD2xzdKfA3TXmyP
         8xJZkZQuTNRUVGIn3LXkL1Gwtb8ndk+KKJccEdJKbyH0fu9LpS23pOgq+Indbut8J7Z6
         7rJVCPttKA71evaY0keC+fd2XXqFezA4km1MurhOmMc75sFi0ckOqLiYGIJyIv/AMGXK
         kcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        fh=cru/MXUf20sIey4R+kXM23/7Zs0L7yrnXaTSf6eKEyM=;
        b=fK1Y3y+YtQtDREhUHSUKeBVN++WwNdCISaWIDNzjheGYQ7sPqOK6OavEzj331b6LqO
         dLO/CBjj0zc+yXi1qL9sWLDHzY+nZfZx51GWvDOG7GVG3j/0FvKeA/S3L9K8tNlHTvoy
         CHHLVSkyOvAhPWc5z5dnzzzyYcJBeYms6B2WjZBaGJnhugJEwFAr0YRYmNznQZ6QjzUK
         L4XBCZY51A2qrlesWGs5MslbstfhS5EGLqKhDOQGMq6m04kGNOzqY4PxoOx7gH6qTGNl
         ilVZ9VTLSLicGAByaiYpkcMFuJU3yPNQtlcPsrd/3YI+q4QREM7qWpIxmicy2XKPP9bw
         Gt3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792513396; x=1793118196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        b=Xua+F94xPs4SLRFvPHZvf8ENdD6xQkEFYVjamT9EZRzYSfJtvS7XDtwmZyz1gTEJ0Z
         /WkxlqQ5rxEvkZKLXwDC4ALxhuuf3lvKENwOAe2FrlDflythScAJ0Tn5Atp7/sUdwsFJ
         E5biZmC8UmGgW0KNyTHjULGeLnoa0QbAm6UUD7R5xj70LVhv4dsixEwE51Pjds0Owm/s
         yh4EPRS7zc5XwowJlsvmHsNHogBe1Cs3eCTy7l+wjYHJVHHx8KQKzvWnrNZKclhTNIQm
         ckqTqXGWGJiMJjLhtJ75lQ1ZbkeOSru9OrP82Q8PUanZ2j0r8yLVhiS2BLjqoKfeus8q
         kXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513396; x=1793118196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        b=R1QnFxLwFQNdG8ydbKQ3Ae4WhKfivoPFe09kvxOCeRnnb14agXlysj4u0dPjuABNcw
         2qNmTPyoutvETUfqkitXThDfwXlKScDbjHg5SL0wOD4KtG2f2Z/Uua7ErFPwqoEnqGcH
         j+MeQ0hxmsURo+Jg5hkntYs9Sf88CCpltouBjpkOHgAFkAzR3RECIsjW6Cj+Jm91RGws
         osxq5yYXUDD2REMmFAXbF4HM2PTY8Vc5XhzrdBiJZlTGAg/HuFopMj7rZs+iskbz3zzO
         VcyaesyfESY2W7q69T9UxPo1cVmB3v9JL3u2h2Cq8y1+MWzlBL6VOfnTEmpKAwYsZS8O
         ctUw==
X-Forwarded-Encrypted: i=1; AKwUvByXKGK7jifYs76SXLIBsJ9m0sbWP28kr7cg6KbC5q4pS/G2KflafDCjM1Pqr37DpDT5DFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0C+tJzz3SgutqHywwmZ8imypGEAW7W8FwHrvz77e3WjY0o5r3
	xTWNrh+9uJpsU8xoL/xMHMbT/FZMIQd8LzpsM2EFXinOHspVSAsOKVMMr2HElk7xsKbkge5s+Z8
	1Ecy0b5i0qRXga1rgJ5sCgVn88vIAoB3PQbKCg1Pa
X-Gm-Gg: AYBFou3+NA/YC6YykJ86KbAsVEUZb9cEADXJr01BaFCVCaoCK02X75/jtWPEi/vvF4h
	TUAVLvwbmL2I6Ax8hovhCtvcG5iD7Fyefphf9oVScaoNugWCRcxS52wxXNW579ORNRFk5uHdFdC
	qxAN4Q5CnW133VSnW1L9AF2EyLYlKXyBly4Bdr09X5a0yCDota743+8Nbom7GgtGyY1itfPUuPk
	hvdc5PiXitQhOR54HpRcFpluLhuVm36t9SVCchTl69QXdb4QAvS39lJThKyZ8PKZN5LMFDg2adu
	6LNauvN0qq9rrBX0r5DCLpYKZMf3Dl4QJMyhLydv2LdMQ5aT4Vog
X-Received: by 2002:a05:6402:a593:10b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b3e59e5999mr68410a12.4.1792513395686; Tue, 20 Oct 2026
 09:23:15 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com> <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
In-Reply-To: <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 09:23:03 -0700
X-Gm-Features: AclHuK98NB_XkoOPCMHRm8iUlfrFJ_YYRk69JLvIRXvJ8G4hhuCyWlkE4iWtFOw
Message-ID: <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net: unify symmetric netmem and page_pool refcounting
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Wed, 14 Oct 2026 17:37:14 +0000 you wrote:
> > netmems (pages and net_iovs) have two independent refcounts: a non-pp
> > refcount (page._refcount or binding->ref) governing backing memory
> > lifetime, and pp_ref_count governing recycling within a page_pool while
> > page_pool holds a single backing non-pp reference. SKBs with
> > pp_recycle=3D1 own pp_ref_count references on page_pool fragments; SKBs
> > with pp_recycle=3D0 own non-pp references.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v3,1/6] netmem: rename __get/__put_netmem() to get/put_net_=
iov()
>     https://git.kernel.org/netdev/net-next/c/a868720467d9
>   - [net-next,v3,2/6] net: skbuff: add napi_pp_get_page() and use it in t=
cp_recvmsg_dmabuf()
>     https://git.kernel.org/netdev/net-next/c/729a47b803b5
>   - [net-next,v3,3/6] net: skbuff: replace skb_page_unref() and __skb_fra=
g_unref() with skb_netmem_unref()
>     https://git.kernel.org/netdev/net-next/c/4d688084070e
>   - [net-next,v3,4/6] net: skbuff: replace __skb_frag_ref() with symmetri=
c skb_netmem_ref()
>     https://git.kernel.org/netdev/net-next/c/1f6f88105e1d
>   - [net-next,v3,5/6] net: skbuff: use skb_frag_ref() in skb_try_coalesce=
()
>     https://git.kernel.org/netdev/net-next/c/447f58db3505
>   - [net-next,v3,6/6] net: kunit: test netmem, page_pool, and skb frag re=
fcounting
>     https://git.kernel.org/netdev/net-next/c/2285346afc99
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

This is awesome. For years the skb refcounting annoyed the hell out of
me. I couldn't fix it on my own; there were too many edge cases I
didn't thoroughly understand and could break. LLMs made this possible.
Thanks!

--
Thanks,
Mina
