Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D874AA3E0
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390121; cv=pass; b=Qpegg90Hcl0oiJnSuhEfgStY78gtZLzQ/OnOF9DVgO8cA9X9M3NZW4lY8TVzYgUhoENhOev878Xk28jk2UwhQ6gzME417OwZFhmI4ZKKPx/IcA8L9odHxqIrLJ8M/3aojx7e7zZIB3rBghgex8SrgTE29fHVx3Pz+8Ix+7fBrgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390121; c=relaxed/simple;
	bh=g9tCop5zoCMY+d7TLajWf9aFiLhGXb6aA76zJr6Y5bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9j1+/8M9pW7bN9w7rsyDWW7hr/hShhWkpX9JKC/hNljfO55WwAlB2iR+NVXGSqzAT0UB0wqE+7vmdlZdk3mY/wmA3Ftn9VNWOafu4OXVd3xY54ElsZZyE9+n1+ev3zl+NE+2iH/ihJxVvIgIXNwRV5jkmlsl9IS8/BXZ0XVqbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijxB2gNu; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijxB2gNu"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f58dce2ad9so1428746b6e.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 09:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791390115; cv=none;
        d=google.com; s=arc-20260327;
        b=Sr8e6uFSppuCq6f/SrcdvBV+K9SsK/avzSAyH9CYjCo0ElIIRCOidCogDtW7bKIe24
         BqRl1qTf+zT4UPtGefG/nYUfaSqryax8D5cTuNGZ6rQeuI/RWEceOOsPq80S3cAc/Yli
         WCSD2z2j2QD/ljSl3TJPJzr+yVPdMFQ0crtPfeu8poGYK9pNQm9+rInpOAmLCxQ9U0An
         V5roJcjQn30OOh/m7JXp7IUQD6QEIJYKUlCgn5QtErlfIfMtfSEIFgynrDsz8HjPOzFb
         9nU8dKNFGA/GtRAggjQovQypWn0Uev4hN4qqDW4BJYAediTUoP9JdgziKMaosiJVFEsb
         o5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g9tCop5zoCMY+d7TLajWf9aFiLhGXb6aA76zJr6Y5bA=;
        fh=Paqg5dtBzp7mHOrFRUsj4mphJJitYFSrL1MpmN4/rQM=;
        b=fNH7kc6P+Chsaep2wv4aJjBQENaN/9arqjqzLkD48UL/2fx5XOiU5iEOYLw4icEmKI
         SAFUhW2Y96FDGIafCwgiK4S2T0WPo5Z6Gp1HuvA03XYQla4Iir3VJ9l/xmWFdeiHhGCX
         q7egbJeERHmN7um/JEbjLS2ht6srV30RYFRH+GE24jalZdWXuKFap30DvEnDddq3Kt71
         h0P5eIOJapI+XMCJEpTn15GMCNQOhsnk8Zsj1HNQx3x1SrSm/mTVWdzJ2wpAPV8GiVA1
         NQmIpMKq9iEZoDduKqQqCUyI/93H/T85DvyF05g/44XZ5aRlyvdkfjrFVzLn0/6jSvCs
         HU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390115; x=1791994915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g9tCop5zoCMY+d7TLajWf9aFiLhGXb6aA76zJr6Y5bA=;
        b=ijxB2gNu+sDHMX/g3ZN0L1dAjYzrA10XNLGjboekiZI+BBUSqPXzCoUKJmVAYHzGYh
         Yq6GlF9G3GuQPjbPOFYeg5exiRXS/HeuFGSG7sHfGgoHTQtPNNb/Cniyuch19Q/Z3Ts3
         bwhUy9h+tiY1aVxysYTl+6BLfWRatZb/+77FQJg6B5lYv68XPG03mriqQpLvaP6xbzGT
         fPKvOYthcswRUufLc0blGjxffQ2slJPtiD5s15qehKtEcRm/BWs/+ol77PlnyO8MMBIY
         4kVf7Oo5l3khPmw4th7YkP5DagEaIe7VQOvyLV89ily9qVguH4CV2kykTT62cb1tLXBO
         u3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390115; x=1791994915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9tCop5zoCMY+d7TLajWf9aFiLhGXb6aA76zJr6Y5bA=;
        b=BEBoqhhG+T+g7ofwQd5QKmbxMXlvqC3iJ0C+O6f280GIqZnqxDnW94WjmM2mMQGdP1
         c3XQ2ToHMnl6MjvZhqv5cYPQjgxEZVaDG537C6OIEEIh7LPUNqsPe9/CviAp/IfisYx/
         1B4c24deLJwOGogHHiqd4iydPcztVf3PEnizgvkwT6gzNYXbTkzJ3vzPYIbeHhXo0jot
         gq67fGcDTegrNq3pvtD2tDvX9TJHZdM6B15mIPj2qkJggHor16h4NE7maaum8SBW/T6R
         TaT0oBSAAjOoWe48c9rc3/03jApRN2AxbcrAH4+v9osx16THuU4eP5BHSoBNdOjUxEz2
         XEuw==
X-Gm-Message-State: AFuF++lDKc5rOatnZSDivVh32eL3WNjAyW4/KOWjgIR01r55pS8JsEXZ
	dVbNASG1ybfdd1pF2SOjj/LfPhMOHlq4SuwEiqSJ/JC5fX+XevLYHO1f4D4Qc0uU0kAqe7B4QtJ
	1LlgFdsXNoOGPKHWuyGaXTyvDUllTu/g=
X-Gm-Gg: AYBFou1T8/Avpn+b1W/I0z63TbdtfMcvanan75H8yCFS+nBTVrFmjWjOVAFP4XxkISG
	eME5kVc+TwerL3XkYWURaAiFWSIdTNl1SlwFalFZWlhXaMVTA7a7UkQDgTwT1SL1tEPjnwwJkB0
	pgmb7ufltIqVQ9Xs3MisHMatrPZaxkp3+Ow7t7DBzTSVc+79tUJnPPr2tJ9zssKBM2N6Np9V0Se
	5cz//i6Bwl4MPJGYNdmDNOIbDj1umHRUJ/KtRJzb4vIpNMEkXVsAHSwsYwrzeV6X5QnvY7uZ0gr
	jtWETy6pNvfrJXXEkOfHV7E5TYuiWHsAbPH8+oZcpcbL8Bjw+8OkmXik9Wvrp2nibQ==
X-Received: by 2002:a05:6808:178c:b0:4d6:92b3:5c8d with SMTP id
 5614622812f47-4fc4729b24dmr3227433b6e.67.1791390114701; Wed, 07 Oct 2026
 09:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007150549.1334-1-rahadbhuiya2021@gmail.com>
In-Reply-To: <20261007150549.1334-1-rahadbhuiya2021@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 09:21:43 -0700
X-Gm-Features: AclHuK-lcUeqI9NiguS8VMWVVE_wtlOyxQO6cWWmZmsk2fhZ7MRTMi5LuUv6lLI
Message-ID: <CAMB2axOqDzQME0ENnX2jVcJTpByFByZneeG0sLOxfEMK5OJ8Gw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: mark kfunc memory size argument precise when
 buffer is null
To: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:12=E2=80=AFAM Rahad Bhuiya <rahadbhuiya2021@gmail.=
com> wrote:
>
> check_kfunc_args() allows a null buffer register paired with KF_ARG_MEM_S=
IZE. When buff_reg is null, check_mem_size_reg() is bypassed via break, lea=
ving the corresponding size register at argno un-marked for precision.

This should already be fixed in f16e80c2c451 ("bpf: Fold __szk const
size handling into the scalar arg path"), currently only in bpf-next.
