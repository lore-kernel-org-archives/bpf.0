Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070D158538
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771471494; cv=pass; b=hUcpL3XMxY4INNK09WtzsVWnR8UVpzhayGZqviNaYioqXfz2CH9KLkxZt7aIhEa7sNzbbyfFrwfPqNuhuMRUXMYwIuMUReEQFRjIMYQbMEeqQzXXFbcYGNTc8Ll1H0BjOnmQYEWDTAKHmDFaCnLsfDr+neky+unle0iD567PXbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771471494; c=relaxed/simple;
	bh=1W9Url9yghD4Wp8JUkueTJreLT1uaGq98XCSoLczUEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnld8KQwfAWDVVG/BWkM7999/BAyq2e4wYTmxJPZonWM8ACU0275RD2VoJ0+VUAEWgltdt4bt345u543n50s7GgTcjFUz0RZUDazpwa0/3JzsJyfyllQmXz5IGy/n6anYkHsr7Wz7wmASQyMall9Gv6RWBz7fqMT8vBKGmSiL5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bStsQ9bH; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bStsQ9bH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359a316d89so429840f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771471491; cv=none;
        d=google.com; s=arc-20240605;
        b=S2zaQY2U9k8oEl5P5VSPRFPvFKqKfD51cC1baUw5Spk1DJPz4Mu9IEH1PK0dIlzcZj
         46LsMs/n78HQglk5vcvK1HOAdPCu+iwhIAIwLGPXVWmCIWTJUZ1bdu0HD4RA3HvN2MY7
         DwN4UlbXp31hSL+wo3UD2XIax779cXr6lNjXhj11Ek4ohtDZX17uhmh9dGBkJzoO313c
         AIC4LDbeEfyRDT+Zq6UZAAtcVrZHIcYSkpRHRIleHLDQ3pYioO8KLrc0oBALYDQ70DS7
         e3YS545NoN2/XfR7diEyzqpIk5bBIIMzl7C43ngqoK64wcPesqnt6FUkMRbhGp5lC8Ms
         5lvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/WhPcYiUl1sYwm/26gXJVcTcQ2P84Z/CFc67awt/sds=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=OvkI04hgpHvGLx5gB4wYlc0soJj/S4lquwStqptp+19UiZssEvKnTl8qN8Cyu+d9As
         o39DuohTusGx+/zJIzqq1qxVLk449KDDzcmFyYRWhc448P+okEniJNM3qlzJHNjDP5+2
         cnfGHNaVW0+YiTQgqhSkHSKJSOI/fXKxepeoEEtsAZtZjldKhk9ntjq/smyN0TBiAmlv
         htr0mPa5pB68oQZrx98sbX/cGlgJ8M+KyeDkHwnjZkOwDXSkH/3mTC5eUz36jxnqpAZ9
         u0QTIegjjXr7lE3wsrRYXpQA6eAuvCBJiJfkvsDZ82CyavHCJQvSvJNSHOqbWW7lAPM3
         DbKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771471491; x=1772076291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WhPcYiUl1sYwm/26gXJVcTcQ2P84Z/CFc67awt/sds=;
        b=bStsQ9bHwiJ59fbiVI4Q7Do+qzozV7Z4kOAbTdNO8qmDuLhWEyxVUfujqBlnv/V68T
         Hws7kq2uWJWMEMIXHic+j5HqB9w/OkQfHSCwqXLOx/H/niDhNiZPp346rRmO5jtWQMQz
         9xSj+LVUbIEQzlVvkHSHzqNftOsxtHR0z4RT7KV9jHOKT9E8ZhT/+faT46CcePogvVWP
         LvO64C6bWmnvqZH7TkCR3TEp/7gLWz9BdH7zX+sVw5jsvKkN3jtsZ6IsXL+C69w9ZsEW
         y4uYXbQMdHmT3VgVBJbyN4IoYDaJA1AQMREqLnX8wla53B182FHIZvvfsSZs2rvCk0te
         O4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771471491; x=1772076291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/WhPcYiUl1sYwm/26gXJVcTcQ2P84Z/CFc67awt/sds=;
        b=nlhG7MM8ZiRVqX9W9c+86axr2Ultz8AQBJtiYi1gqdowXlaiYm0cr+3EvT/PNQgCE5
         v2IWzP9nHazhujb+eR7/pxNL1vSENvvUp1S+J7uXYs7g7JdMBJ8TM98P+HV5YpA+wtJs
         l9L0HB35Zpe9dk+67FoKC+PAA9Kp4WOUApeCgZbrPemabIVOJGGyeB5cH029hoMt02CP
         IOaCNANIIzjq8RrkY96ufVrWZhODYZoSFjOQ9mEaQh86aaj/tYOMruI9k5tkofu4mnJ2
         GpcvjspFPrKq8gRUHAoAxgO0gpKH8dauk0zndBLdJjKlibdmZrBlCj/dy5lhTFLuprcS
         bxZw==
X-Gm-Message-State: AOJu0Yzem/HkTtEQ5EZCmmU0n57gkdVtO3ntPILeB8D1ezD19FoHyPpI
	UBOm6eJLMaE8G/3fadKPqAdCfWQZctfdQLwXNmd7LBNJrmp29xq52AO/CGKvj/hgIts+ffXqnbz
	UgroJu6tb50Do8Hn/VxgieQTbJQ33QKI=
X-Gm-Gg: AZuq6aKoyEsEKjYpZVge9jm1BZdTN6TQqNXYnHAhwlF5ZiiM+2BFhMgEngUFY3Gter/
	p6OyiZyny9UFMPhBtxtxTOhJxBgiiBVQMIqP0fjTJTeaK8P8PMx+E6zIFS4zsTQSivHH95SpLtm
	OZlvv5Xf3DtPRNDkAxp9ryQRGdzbdo74WiNWfROsHhc2JV9fpxpeIVy0+VQkJxvRUrjCvEUj3I0
	d5QiuXnK+IEVQSXokC1wvFvXkB3AG7PZAXc42F+q6VFEWDp0pvNqZFJN/uhUbzo99zb4QEXbPQr
	lEknsgtpyZ9XUPAtAE3hAAp0atS3Ihnh9sYqNZ53UQUbY17cJGBH88pcajDn2gs9C/vOuTXKZct
	Ha+DSnUe4MA3fAmp/+FLyBVzx7NvsHprcdHAf
X-Received: by 2002:a05:6000:24c5:b0:42b:2dfd:5350 with SMTP id
 ffacd0b85a97d-43958e5a5d5mr7220757f8f.56.1771471491048; Wed, 18 Feb 2026
 19:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218182555.1501495-1-puranjay@kernel.org> <20260218182555.1501495-3-puranjay@kernel.org>
In-Reply-To: <20260218182555.1501495-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Feb 2026 19:24:40 -0800
X-Gm-Features: AaiRm50XTPz0VWkp5yZjA0vlEJoRo-DDXnCvAqUvPQs8FyztqNDuZEbnxxkXtbE
Message-ID: <CAADnVQKm+oNX704R8sZrbaHFnmvjC2yBw-UT+T3O4FQ0Rxuavg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 10:26=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> @@ -20054,6 +20086,9 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
>         if (old->active_rcu_locks !=3D cur->active_rcu_locks)
>                 return false;
>
> +       if (old->forbid_sleep_count !=3D cur->forbid_sleep_count)
> +               return false;
> +
>         if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
>                 return false;
>
> @@ -20067,6 +20102,9 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
>                         return false;
>                 switch (old->refs[i].type) {
>                 case REF_TYPE_PTR:
> +                       if (old->refs[i].forbid_sleep !=3D cur->refs[i].f=
orbid_sleep)
> +                               return false;
> +                       break;

I don't like yet another special case.
We already have active_locks, active_rcu_locks, etc.
All that is way too specific. Let's figure out a generic way
or piggy back on existing active*, since all of them already prevent sleepi=
ng:
static inline bool in_sleepable_context(struct bpf_verifier_env *env)
{
        return !env->cur_state->active_rcu_locks &&
               !env->cur_state->active_preempt_locks &&
               !env->cur_state->active_locks &&
               !env->cur_state->active_irq_id &&
               in_sleepable(env);
}
