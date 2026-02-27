Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D3395DB4
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232498; cv=none; b=DwV/ko5wuhvl8ZYiFgwBl02aE6ID5B40VdAO8Lc8392VA4NZ10r8oWL/o47cIkbdkFfLbGfGTEK+es6soqn6rtHXlDd46CZlH6B+w+0WxrHVN4OMow4tJU4tpVN4lECQplSwyP0sPDKE9fGEK7lu2XLSx8u3Q9ERhHW40gMvPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232498; c=relaxed/simple;
	bh=Je93LqwqVjSAmV6R/W91WZoRL/d5wzTFLq7Iz+DNEUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP5hGYY+ElHGNoMJn5bO20yBkDdP5HcR/7XQgVYOcO0VXCeLSeLc0oVpctnQy5TisRpOSpMqbEszNtsKmPsZOhhlln/8HtDwj2Kq+2tu3B0lw3S+8qE+acV+t/DGeBJos6SPhLc48la5PNVN5kOEI/7DWgu9JpwuSFFbmLRi0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARdU19l6; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARdU19l6"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-463f00cda04so1787687b6e.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232496; x=1772837296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuGVMxQdAc61kh+f4jtCF77OaXHs52GAtdu7nUKy03U=;
        b=ARdU19l6M1S1QfAZQhHUp99pMIBdKMnEJMv/kFWKceydMirsax6nSxBN/iAE1f+IOE
         fFRKH1WAS24ZASYZmzBX9vrxMwWd/3RaTy+oSi/vNwVxweG1uGKH+WMd4WwbvJ6XXXrK
         9pl/Uz5hFMW7iI2UGRv2mQ1SpxZUe6lWITjKXus4ynsIIp0B4gnKCI5kLk6yb/oynxK5
         caLto21ds0nntbgxfW3gNaqMQ/B2ndRTIpntcEu22cDts8bx3U/DPrgWMXYgrjMq7st5
         Ipt8z2YdIm8XmSmb4T4y/F4JX2LLttUo8DWECupA73L9UECE/38aj8Vy2Rak+PLmlA0S
         X3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232496; x=1772837296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuGVMxQdAc61kh+f4jtCF77OaXHs52GAtdu7nUKy03U=;
        b=wZOhrY19tzaPK4pp2QWj3LGbOx5Z8/A/DXmEF8xsVzNEwP5pWEyNvQR2CDQHpVt7jx
         9Rj6M0meGeZFwKFi/Hp4hVxQz/96m/ocVdsDxeXqe+BQvMVxARlhkYK/U7f6bfQaJBNf
         kKALC6RMNoFmHF4uE7QKjCJ/Qg8Nw3HV2oHHPs0WA2ecIN3dTUJ1Fl7GuLpcfeam/TAn
         +lvjmD3gip4pq20lYSBWP3IMgYSR/Jh8jowXVspfChQB50BZV332LNRoclcw3E0IewmC
         j6hdafF7fZ0Khmct64zTgwe6lWyxu+zxsFmSVx4sOZdp8K6K9XrGMc85KAccCjEqrKLa
         f7lQ==
X-Gm-Message-State: AOJu0YybYC0kSce5Il3LUvcrdoOPZQFYS4SZowKr6kMphysgcbgX5sKp
	fZV58CPSiH6cI9o7oJgvk7nb9tN0KKKZpGHDQeLgJm7KNezuTnHHHwO9U/2Pu6x9Nbk=
X-Gm-Gg: ATEYQzyubKSp0eGPHjYw8iAsc5fpTVRUhFNDYdCfWwKqzJsf19BoWZpgigzegMv9PLM
	3S8fRKnpWw0avs4BDGy62HCuJVpWqOIy5/nmOsLi0QLsmTkjQVM28qTl1L0duXrCjrDUHaqcavN
	PKz3XfjoSfmYLPc111vJxFMtZ3C5GDudYtwdEtzLqA0QbQ2UtX5S7e/dxsbN9W3AEq36wjsg+IO
	y5sum/RmL3yzpg9861pM1mzvgsNhhVOXoUgfxB0Ljs5G5RQ5DVrNdA2T4BfrFR0hRDFvDxSrFh/
	+0YmpeTJlpoJX5uaisiz4WN5sMNUpPWldKohE/nglK1V2Lt03YgOvZijm1DtkXP35t0B2hubW+w
	14GjqoOimKzzIuW65DGjDntDoTI3XxPsezDjGPZC2tetfmUdXPaNgpjigDMezz2c8FWAILYoxfk
	h/Tn25uTeoq/uHsY8S0yY19ptz3n2an3bwHgoA19CNaj0=
X-Received: by 2002:a05:6808:1598:b0:45c:832a:cf43 with SMTP id 5614622812f47-464be9a3af0mr2496950b6e.14.1772232495955;
        Fri, 27 Feb 2026 14:48:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb605f15sm2877963b6e.20.2026.02.27.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:15 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 4/5] bpf: Retire rcu_trace_implies_rcu_gp() from local storage
Date: Fri, 27 Feb 2026 14:48:04 -0800
Message-ID: <20260227224806.646888-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
References: <20260227224806.646888-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; h=from:subject; bh=Je93LqwqVjSAmV6R/W91WZoRL/d5wzTFLq7Iz+DNEUk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0r7yjpJRs+xLOjrAzKnsis6iI6UAnLStRA31H7 KT3dT6GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdKwAKCRBM4MiGSL8RyjWAD/ 0VHJNjpFz3b8mv/lUOxzuiEtVk5bSOzJuT68s6buV080AzGoyJ4iI9TvhcHpmJBPp/R5sDrmTQYHBi F5nbWhFibBv5CBqpESKKyUwAi1fExR7Ww/vcgBCuSmkLWqNWra/5fn4O8Zq09HoJ32PI99HTVrX+7W ZAdpfYMC+Fgjjef+sY/iaP8FQ1PpB+PwFNKQekAg2ETsvLMSYzL9mEuYWDtVCUYZ5Tp4ED19cAnu6b BOXAns83/+vBOnhzUfpwgNesWhzpucWmdemeqrryfUWHPfS88HgDsxh0EBZB6uYGJE3YQV7GHIvg6F lMlOiImVMzH5DzC+1in24TJE0z2BtD08ORAlRcx1mhI8EAtzWmVKzfz87zgTtSyCWJUf/nWEPIXOO8 GN+0OPf6ml/tjqj4p2zmNoWgCs1CAPtYpnHqWtoFL2467uCACIz04UGtFxjiN6KxrWs9D8v+4rVLD1 jecfY7JjvjDiSDs3NH5jjFqE1pAPH6GVN2SQsE6M0zCsxCtO8+Ao624YYAQnr/8+ep+wfGp5l7HMCQ 1VAPM4LmviLkKP2BmeDXf7Nr/So2Rza0jm8vG0LPdiCh3kAt/IF4FfCLf14I4I8rjkwDliqnjvVXVi asE5bh5M63nSv6OI58eG7Xcdr2YumevuDr7lXaXroSdXmWke2qkoBuKCzuAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This assumption will always hold going forward, hence just remove the
various checks and assume it is true with a comment for the uninformed
reader.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d7db1ada2dad..9c96a4477f81 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -107,14 +107,12 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
-	/* If RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree(), else do kfree_rcu().
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
 	 */
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	if (rcu_trace_implies_rcu_gp())
-		kfree(local_storage);
-	else
-		kfree_rcu(local_storage, rcu);
+	kfree(local_storage);
 }
 
 /* Handle use_kmalloc_nolock == false */
@@ -138,10 +136,11 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		bpf_local_storage_free_rcu(rcu);
-	else
-		call_rcu(rcu, bpf_local_storage_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	bpf_local_storage_free_rcu(rcu);
 }
 
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
@@ -182,10 +181,11 @@ static void __bpf_selem_free_rcu(struct rcu_head *rcu)
 /* rcu tasks trace callback for use_kmalloc_nolock == false */
 static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		__bpf_selem_free_rcu(rcu);
-	else
-		call_rcu(rcu, __bpf_selem_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	__bpf_selem_free_rcu(rcu);
 }
 
 /* Handle use_kmalloc_nolock == false */
@@ -214,10 +214,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		bpf_selem_free_rcu(rcu);
-	else
-		call_rcu(rcu, bpf_selem_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	bpf_selem_free_rcu(rcu);
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-- 
2.47.3

